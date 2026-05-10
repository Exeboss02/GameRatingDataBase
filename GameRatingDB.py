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
    
    
def Call_Procedure(connection, should_fetch, procedure_name, parameters):
    cursor = connection.cursor()
    try:
        kleng = ("name", 33, "hehe")
        cursor.callproc(procedure_name, parameters)
        result = None
        if(should_fetch):
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
    result = Call_Procedure(connection, True, "InsertUser", parameters)

    print("Inserted user :", username, ": successfully")
    return result


def Insert_User_Rating(connection, username, game_id, story_rating, game_play_rating, visuals_rating, sound_rating):
    parameters = (username, game_id, story_rating, game_play_rating, visuals_rating, sound_rating)
    result = Call_Procedure(connection, True, "InsertUserRating", parameters)
    
    # idParameters = (name)
    # idResult = Call_Procedure(connection, True, "GetStudioIDs", idParameters)
    
    print(username, " rated the game with id :", game_id, ": successfully")
    return result
    
    
def Insert_Studio(connection, name, nrOfEmployees, country):
    parameters = (name, nrOfEmployees, country)
    result = Call_Procedure(connection, True, "InsertStudio", parameters)
    
    # idParameters = (name)
    # idResult = Call_Procedure(connection, True, "GetStudioIDs", idParameters)
    
    #this introduces a bug where games with same name will only print the first entry of that title here, but is fine for most use cases
    print("Inserted studio :", name, ": successfully")
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
    result = Call_Procedure(connection, True, "InsertGame", parameters)
    
    # idParameters = (title)
    # idResult = Call_Procedure(connection, True, "GetGameIDs", idParameters)
    
    #this introduces a bug where games with same name will only print the first entry of that title here, but is fine for most use cases
    print("Inserted game :", title, ": successfully")
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


def Games_By_Studio(db, studio_id):
    result = Call_Query(db, "SELECT Games.*, Studios.Name FROM Games INNER JOIN Studios ON Games.StudioID = Studios.StudioID WHERE Studios.StudioID = '" + studio_id + "';")
    Print_Result(result)
    

def Re_Initialize():
    db = Connect_To_Data_Base("exeboss", "*King1337!")
    
    Insert_User(db, "xxxFredxxx", "Female", 31, "USA")
    Insert_User(db, "Bjorn", "Male", 19, "Norway")
    Insert_User(db, "AndrewScandrew", "Male", 25, "Sweden")
    Insert_User(db, "Landso", "Female", 21, "Australia")
    
    Insert_Studios_From_CSV(db, "studios.csv")
    Insert_Games_From_CSV(db, "games.csv")
    
    Insert_User_Rating(db, "xxxFredxxx", "G0", 5, 6, 7, 8)
    Insert_User_Rating(db, "xxxFredxxx", "G1", 3, 6, 9, 9)
    Insert_User_Rating(db, "xxxFredxxx", "G2", 5, 8, 8, 4)
    Insert_User_Rating(db, "xxxFredxxx", "G3", 10, 10, 9, 10)
    Insert_User_Rating(db, "xxxFredxxx", "G4", 1, 4, 3, 4)
    Insert_User_Rating(db, "xxxFredxxx", "G5", 6, 5, 3, 10)
    
    Insert_User_Rating(db, "Bjorn", "G0", 3, 7, 7, 8)
    Insert_User_Rating(db, "Bjorn", "G2", 5, 10, 10, 1)
    Insert_User_Rating(db, "Bjorn", "G4", 5, 3, 8, 7)
    Insert_User_Rating(db, "Bjorn", "G8", 6, 5, 5, 6)
    Insert_User_Rating(db, "Bjorn", "G8", 4, 8, 10, 9)
    
    Insert_User_Rating(db, "AndrewScandrew", "G5", 8, 8, 8, 10)
    Insert_User_Rating(db, "AndrewScandrew", "G6", 8, 8, 10, 9)
    Insert_User_Rating(db, "AndrewScandrew", "G7", 5, 2, 3, 9)
    Insert_User_Rating(db, "AndrewScandrew", "G8", 10, 7, 7, 2)
    Insert_User_Rating(db, "AndrewScandrew", "G9", 6, 10, 5, 6)
    Insert_User_Rating(db, "AndrewScandrew", "G12", 4, 4, 1, 9)
    Insert_User_Rating(db, "AndrewScandrew", "G14", 5, 5, 4, 8)
    
    Insert_User_Rating(db, "Landso", "G11", 8, 10, 10, 8)
    Insert_User_Rating(db, "Landso", "G12", 8, 6, 6, 4)
    Insert_User_Rating(db, "Landso", "G13", 9, 10, 10, 6)
    Insert_User_Rating(db, "Landso", "G14", 3, 5, 5, 4)
    Insert_User_Rating(db, "Landso", "G6", 7, 7, 10, 9)
    
    result0 = Call_Query(db, "SELECT * FROM Users")
    result1 = Call_Query(db, "SELECT * FROM Studios")
    result2 = Call_Query(db, "SELECT * FROM Games")
    result4 = Call_Query(db, "SELECT * FROM UserRatings")
    print("\n--------------USERS----------------")
    Print_Result(result0)
    print("\n--------------STUDIOS----------------")
    Print_Result(result1)
    print("\n--------------GAMES----------------")
    Print_Result(result2)
    print("\n--------------USER-RATINGS----------------")
    Print_Result(result4)
    
    print("\n--------------NR-OF-GAMES----------------")
    result5 = Call_Query(db, "SELECT COUNT(Games.GameID) FROM Games")
    print("nr of games:")
    Print_Result(result5)
    
    print("\n--------------AVG-GAMEPLAY-SCORE-GROUPED-BY-GAME----------------")
    result6 = Call_Query(db, "SELECT GameID, AVG(GamePlayRating) FROM UserRatings GROUP BY UserRatings.GameID")
    print("avarage game scores:")
    Print_Result(result6)
    
    print("\n--------------EVERY-FROMSOFTWARE-GAME----------------")
    Games_By_Studio(db, "S0")
    
    
    #GamesByStudio uses both JOIN and 2 tables
    #InsertGames uses Studios table to check if StudioID is already present there
    
    return db

        
        
def main():
    db = Re_Initialize()
    

if __name__ == "__main__":
    main()