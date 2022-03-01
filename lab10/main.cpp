#include <iostream>
#include <sstream>
#include <string>
#include <pqxx/pqxx>
#include "test.h" 
#include <fstream>

using namespace std;
using namespace pqxx;

void reader(connection &connlab)
{
    ofstream plik ("wynik.json");
    if (plik.is_open())
    {
        work trsxn{connlab};
        string zapytanie;
        cout<<"Wpisz zapytanie:"<<endl;
        getline(cin,zapytanie);
        getline(cin,zapytanie);
        result res {trsxn.exec(zapytanie)};
        plik<<"[";
        unsigned i =0;
        while (i<res.size())
        {
            unsigned j =0;
            plik<<"{";
            while (j<res[i].size())
            {
                plik<<" \""<<res[i][j].name()<<"\":\""<<res[i][j].c_str()<<"\"";
                if(j!=res[i].size()-1)
                {
                    plik<<",";
                }
                j++;
                
            }
            plik<<"}";
            if(i!=res.size()-1)
            {
                plik<<","<<endl;
            }
            i++;
        }
        plik<<"]";
       
        plik.close();
    }
    else 
    {
        cout << "ERROR Blad pliku";
    } 
}

void writer(connection &connlab)
{
    ifstream plik("dane.json");
    string tabela;
    if (plik.fail()) 
    {
        throw runtime_error("ERROR otwarcia pliku");
    }
    cout<<"Wpisz do jakiej tabeli chcesz zapisac"<<endl;
    getline(cin,tabela);
    getline(cin,tabela);
    string data( (istreambuf_iterator<char>(plik) ),istreambuf_iterator<char>()) ;
    string::size_type first = 0;
    string::size_type last = 0;

    while(!false)
    {
        first = data.find("{",first+1);
        if(first == string::npos)
            break;
        last = data.find("}",last+1);
        string strNew = data.substr (first+1,last-first-1);
        string::size_type separator = 0;
        string::size_type x = 0;
        string::size_type poczatek = 0;
        string::size_type koniec = 0;  
        string klucze="(";
        string wartosci="(";
        while(!false)
        {   
            separator = strNew.find(":",separator+1);  
            if(separator == string::npos)
                break;
            poczatek = strNew.find("\"",x+1);     
            koniec = strNew.find("\"",poczatek+1);
            string k = strNew.substr (poczatek+1,koniec-poczatek-1);
            klucze+=k+" ,";
            poczatek = strNew.find("\"",separator);     
            x = koniec = strNew.find("\"",poczatek+1);
            string v = strNew.substr (poczatek+1,koniec-poczatek-1);
            wartosci+="'"+v+"'"+" ,";
        }
        klucze.pop_back();
        wartosci.pop_back();
        klucze+=")";
        wartosci+=")";
        string sql = "INSERT INTO "+tabela+klucze+" VALUES "+wartosci+";" ;
        work W(connlab);
        W.exec( sql );
        W.commit();
    }
    plik.close();
}




int main(int argc, char* argv[]) 
{
    stringstream ss;
    ss << "dbname = " << labdbname << " user = " << labdbuser << " password = " << labdbpass \
        << " host = " << labdbhost << " port = " << labdbport; 
    string s = ss.str();
    char option; 
 
    try {
        connection connlab(s);     
        if (connlab.is_open()) 
        {
            do
            {
                cout<<"Wcisnij w, aby zapisac dane do bazy danych."<<endl;
                cout<<"Wcisnij r, aby odczytac dane z bazy danych."<<endl;
                cout<<"Wcisnij e, aby zamknac aplikacje"<<endl;
                cin>>option;
                if(option=='w')
                {
                    writer(connlab);

                }
                else if(option=='r')
                {
                    reader(connlab);
                }
                else if(option=='e')
                {
                    exit(0);
                }
                else
                {
                    cout<<"Wybierz poprawna opcje"<<endl;
                }  
                
            
            }while(option!='e');
          
        } 
        else 
        {
            cout << "Problem z connection " << endl;
            return 3;
        }
        connlab.disconnect();
    } catch (pqxx::sql_error const &e) 
    {
        cerr << "SQL error: " << e.what() << std::endl;
        cerr << "Polecenie SQL: " << e.query() << std::endl;
        return 2;
    } catch (const std::exception &e) 
    {
        cerr << e.what() << std::endl;
        return 1;
    }
}

