# pragma version 0.4.0
#@license MIT

from interfaces import i_favorites 

list_of_favorite_contracts: public(DynArray[address, 100])
original_favorite_contract: address



@deploy
def __init__(original_favorite_contract: address):
    self.original_favorite_contract = original_favorite_contract

@external
def create_favorites_contract():
    new_favorites_contract: address = create_copy_of(self.original_favorite_contract)
    self.list_of_favorite_contracts.append(new_favorites_contract)

@external
def store_from_factory(favorites_index: uint256, new_number: uint256):
    favorites_address: address = self.list_of_favorite_contracts[favorites_index]
    favorites_contract: i_favorites = i_favorites(favorites_address)
    extcall favorites_contract.store(new_number)


    
