# pragma version 0.4.0
#@license MIT

import favorites

initializes: favorites
exports: (
    favorites.retrieve,
    favorites.add_person,
)

@deploy
def __init__():
    favorites.__init__()
    print(favorites.my_favorite_number)
    
@external
def store(favorite_number: uint256):
    # favorites.store(favorite_number) # cant do this!
    favorites.my_favorite_number = favorite_number + 5