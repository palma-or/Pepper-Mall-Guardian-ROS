#!/usr/bin/python3
import os

def load_annotations(file_path):
    """Legge il file delle annotazioni e restituisce una lista di righe."""
    if not os.path.exists(file_path):
        print("File non trovato!")
        return []
    
    with open(file_path, "r") as file:
        lines = [line.strip().split(',') for line in file.readlines()]
    return lines

def modify_annotations(annotations):
    """Permette all'utente di modificare le annotazioni per intervalli di righe."""
    while True:
        try:
            start = int(input("Inserisci la riga iniziale (1 per la prima riga, 0 per terminare): "))
            if start == 0:
                break
            end = int(input("Inserisci la riga finale: "))
            print("Opzioni: 1) False,False  2) False,True  3) True,False  4) True,True")
            choice = input("Scegli l'opzione per l'intervallo di righe (1-4): ")
            
            if choice == "1":
                for i in range(start - 1, end):
                    annotations[i] = (annotations[i][0], "False", "False")
            elif choice == "2":
                for i in range(start - 1, end):
                    annotations[i] = (annotations[i][0], "False", "True")
            elif choice == "3":
                for i in range(start - 1, end):
                    annotations[i] = (annotations[i][0], "True", "False")
            elif choice == "4":
                for i in range(start - 1, end):
                    annotations[i] = (annotations[i][0], "True", "True")
            else:
                print("Scelta non valida, riprova.")
        except ValueError:
            print("Errore di input, inserisci numeri validi.")
    
    return annotations

def save_annotations(file_path, annotations):
    """Salva le annotazioni modificate sovrascrivendo il file originale."""
    with open(file_path, "w") as file:
        for frame, person, face in annotations:
            file.write(f"{frame},{person},{face}\n")
    
    print(f"File sovrascritto: {file_path}")

if __name__ == "__main__":
    file_path = input("Inserisci il percorso del file delle annotazioni: ")
    annotations = load_annotations(file_path)
    
    if annotations:
        modified_annotations = modify_annotations(annotations)
        save_annotations(file_path, modified_annotations)

