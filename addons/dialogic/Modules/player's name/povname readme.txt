this module will work with a special prompt command which would be this 

    # Character name input
    $ povname = renpy.input("What is your adventurer name?", length=32)
    $ povname = povname.strip()
    if povname == "":