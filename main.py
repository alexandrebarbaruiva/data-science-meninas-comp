import pandas as pd
import numpy as np
import os
import csv

def extrai_dados(link):
    my_dataframe = pd.read_csv(link, sep = ";")
    return my_dataframe

def exporta_data_frame(df, name="resultado_final"):
    with open(name + '.csv', 'w') as arquivo:
        df.to_csv(arquivo,sep=";")

def visualiza_dados(df):
    print("Summary")
    for collumn in df:
        print(collumn)
        print(pd.value_counts(df[collumn].values, dropna=False), "\n")

def verifica_mulheres_sem_apoio(df):
    return(df[df['Gender'] == 'F'][df['Family.Approves.CS.Major'] == 'No'])

if __name__ == "__main__":
    local_path = os.getcwd()
    full_path = local_path + '\\dados_meninas_comp.csv'
    data_frame = extrai_dados(full_path)

    # visualiza_dados(data_frame)
    clean_data_frame = verifica_mulheres_sem_apoio(data_frame)
    visualiza_dados(clean_data_frame)

    exporta_data_frame(clean_data_frame, "mulheres_sem_apoio")