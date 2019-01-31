words = input().split()

for word in words:
    print("\"" + word.upper() + "\" {return K" + word.upper() + ";}")
    print("\"" + word.lower() + "\" {return K" + word.upper() + ";}")
