import pandas as pd
import numpy as np
import mysql.connector
from mysql.connector import Error

def Connect_To_Data_Base(username, password):
    connection = None
    try:
        connection = mysql.connector.connect(
            host="localhost",
            user=username,
            password=password)
        
        print("Connection to mysql server succeeded!")
        return connection
    except:
        print("Connection to mysql server failed!")
        return
    
    
def Call_Procedure(connection, procedure_name, parameters):
    cursor = connection.cursor
    try:
        cursor.callproc(procedure_name, parameters)
        result = cursor.fetchall()
        return result
    except Error as error:
        print("Error: ", error)
        return


def Insert_Studios_From_CSV(connection, path):
    cols_to_use = ['Name', 'NrOfEmployees', 'Country']
    
    data = pd.read_csv(path, usecols=cols_to_use)
    
    for i, row in data.iterrows:
        name = row['Name']
        nrOfEmployees = row['NrOfEmployees']
        country = row['Country']
        
        try:
            parameters = (name, nrOfEmployees, country)
            result = Call_Procedure(connection, "InsertStudio", parameters)
            
            idParameters = (name)
            idResult = Call_Procedure(connection, "GetStudioIDs", idParameters)
            
            #this introduces a bug where games with same name will only print the first entry of that title here, but is fine for most use cases
            print("Inserted :", name, ": with StudioID: ", idResult[0][0], ": successfully")
            return
        except Error as error:
            print("Error: ", error)
            return
    return


def Insert_Games_From_CSV(connection, path):
    cols_to_use = ['StudioID', 'Title', 'Platform', 'ReleaseYear', 'SoldCopies', 'Genre1', 'Genre2']
    
    data = pd.read_csv(path, usecols=cols_to_use)
    
    for i, row in data.iterrows:
        studio_id = row['StudioID']
        title = row['Title']
        platform = row['Platform']
        release_year = row['ReleaseYear']
        sold_copies = row['SoldCopies']
        genre1 = row['Genre1']
        genre2 = row['Genre2']
        
        try:
            parameters = (studio_id, title, platform, release_year, sold_copies, genre1, genre2)
            result = Call_Procedure(connection, "InsertGame", parameters)
            
            idParameters = (title)
            idResult = Call_Procedure(connection, "GetGameIDs", idParameters)
            
            #this introduces a bug where games with same name will only print the first entry of that title here, but is fine for most use cases
            print("Inserted :", title, ": with GameID: ", idResult[0][0], ": successfully")
            return
        except Error as error:
            print("Error: ", error)
            return
    return
    
        
        
def main():
    connection = Connect_To_Data_Base("", "")

if __name__ == "__main__":
    main()