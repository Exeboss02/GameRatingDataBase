import pandas as pd
import numpy as np
import mysql.connector
from mysql.connector import Error

def Connect_To_Data_Base(username, password):
    db = None
    try:
        db = mysql.connector.connect(
            host="localhost",
            user=username,
            password=password,
            database="GameRatings"
        )
        
        print("Connection to mysql server succeeded!")
        db.commit()
        return db
    except:
        print("Connection to mysql server failed!")
        return
    
    
def Disconnect():
    connection = None
    try:
        connection = mysql.connector.close(host="localhost")
        print("Successfully disconnected")
        return
    except:
        print("Disconnect failed")
        return
    
    
def Call_Procedure(connection, procedure_name, parameters):
    cursor = connection.cursor()
    try:
        cursor.callproc(procedure_name, parameters)
        result = cursor.fetchall()
        connection.commit()
        return result
    except Error as error:
        print("Error: ", error)
        return
    
    
def Call_Query(connection, query):
    cursor = connection.cursor()
    try:
        cursor.execute(query)
        result = cursor.fetchall()
        connection.commit()
        return result
    except Error as error:
        print("Error: ", error)
        return
    
    
def Print_Result(dbResult):
    for row in dbResult:
        print(row)
    
    
def Insert_User(connection, username, gender, age, country):
    parameters = (username, gender, age, country)
    result = Call_Procedure(connection, "InsertUser", parameters)

    print("Inserted user :", username, ": successfully")
    return result
    
    
def Insert_Studio(connection, name, nrOfEmployees, country):
    parameters = (name, nrOfEmployees, country)
    result = Call_Procedure(connection, "InsertStudio", parameters)
    
    idParameters = (name)
    idResult = Call_Procedure(connection, "GetStudioIDs", idParameters)
    
    #this introduces a bug where games with same name will only print the first entry of that title here, but is fine for most use cases
    print("Inserted studio :", name, ": with StudioID: ", idResult[0][0], ": successfully")
    return result


def Insert_Studios_From_CSV(connection, path):
    cols_to_use = ['Name', 'NrOfEmployees', 'Country']
    
    data = pd.read_csv(path, usecols=cols_to_use)
    
    for i, row in data.iterrows():
        name = row['Name']
        nrOfEmployees = row['NrOfEmployees']
        country = row['Country']

        result = Insert_Studio(connection, name, nrOfEmployees, country)
    return


def Insert_Game(connection, studio_id, title, platform, release_year, sold_copies, genre1, genre2):
    parameters = (studio_id, title, platform, release_year, sold_copies, genre1, genre2)
    result = Call_Procedure(connection, "InsertGame", parameters)
    
    idParameters = (title)
    idResult = Call_Procedure(connection, "GetGameIDs", idParameters)
    
    #this introduces a bug where games with same name will only print the first entry of that title here, but is fine for most use cases
    print("Inserted game :", title, ": with GameID: ", idResult[0][0], ": successfully")
    return result


def Insert_Games_From_CSV(connection, path):
    cols_to_use = ['StudioID', 'Title', 'Platform', 'ReleaseYear', 'SoldCopies', 'Genre1', 'Genre2']
    data = pd.read_csv(path, usecols=cols_to_use)
    
    for i, row in data.iterrows():
        studio_id = row['StudioID']
        title = row['Title']
        platform = row['Platform']
        release_year = row['ReleaseYear']
        sold_copies = row['SoldCopies']
        genre1 = row['Genre1']
        genre2 = row['Genre2']
        
        result = Insert_Game(connection, studio_id, title, platform, release_year, sold_copies, genre1, genre2)
    return

        
        
def main():
    db = Connect_To_Data_Base("exeboss", "*King1337!")
    Insert_Studios_From_CSV(db, "studios.csv")
    result = Call_Query(db, "SELECT * FROM Studios")
    Print_Result(result)
    

if __name__ == "__main__":
    main()