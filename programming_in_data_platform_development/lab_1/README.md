• peka ut ingest —> storage —> transform —> access (teori)

- Ingest: är när data tas in i systemt. i vårat fall:
```python 
    pd.read_csv("lab.csv", sep=";")
```
- Storage är där data lagras. I detta fall är det csv-filen, lab_1.csv men även de filerna som avi genererar, analytics_summary.csv och price_analytics.csv. 

- transform är när vi:
    * städar data
    * konverterar price till numeriskt värde
    * konverterar created_at till datetime
    *skapar valideringsregler m.m. 

Exempel 
```python 
    lab_df["price"] = pd.to_numeric(lab_df["price"], errors="coerce")
```

- Access är när vi räknar ut: 
    * snittpris
    * medianpris
    * antal produkter
    * antal saknat pris

• känna igen teknologityper (Psycopg3, Pandas) (teori) Bonus: pydantic

- Pandas är ett python bibliotek som används för: 
    * datahantering 
    * transformation 
    * analys
    * csv-hantering

- Psycopg3 är ett python bibliotek för att koppla python till PostgreSQL. Det används för att:
    * skicka sql-frågor
    * lagra data i databas 
    * hämta data från databas 

- Pydantic används för datavalidering via mdoeller:
    * Säkerstäkka att price är float
    * Säkerställa att id inte är tomt 
    * Säkerstäkka att datum är korrekt format 

• förklara Extract —> Transform —> Load (teori)

- Extract: som vi använder oss av för att läsa ut data ur lab_1.csv i detta fall men kan även användas i olika databaser eller API. 
```python 
    pd.read_csv("lab.csv", sep=";")
```

- Transform använder vi för att städa whitespaces, konvertera datatyper, filtrera ogiltiga rader och skapar analytics. Dvs. att dat arensas, valideras och struktureras. 

- Load: vi laddar eller sparar resultatet till nya filer. I detta fall olika csv-filer i detta fall men den transformerade datan kan såklart användas på flera sätt. Den kan laddas in i en databas eller andra typer av analysfiler. 