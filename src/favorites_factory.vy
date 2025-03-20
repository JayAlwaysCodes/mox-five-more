# pragma version 0.4.0
# @license MIT

from interfaces import i_favorites

list_of_favorites_contracts: public(DynArray[i_favorites, 100])
original_favorite_contract: address

@deploy 
def __init__(original_favorite_contract: address):
    self.original_favorite_contract = original_favorite_contract

@external
def create_favorites_contract():
    new_favorites_address: address = create_copy_of(self.original_favorite_contract)
    favorites_contract: i_favorites = i_favorites(new_favorites_address)
    self.list_of_favorites_contracts.append(favorites_contract)

@external
def store_from_factory(favorites_index: uint256, favorites_number: uint256):
    extcall self.list_of_favorites_contracts[favorites_index].store(favorites_number)

@view
@external
def view_from_factory(favorites_index: uint256) -> uint256:
    # Ensure the index is within bounds
    assert favorites_index < len(self.list_of_favorites_contracts), "Index out of bounds"
    
    # Get the i_favorites contract at the specified index
    favorite_contract: i_favorites = self.list_of_favorites_contracts[favorites_index]
    
    # Perform a static call to the `retrieve` function
    response: Bytes[32] = raw_call(
        favorite_contract.address,  # Access the address from the i_favorites interface
        method_id("retrieve()"),   # Method ID for the `retrieve` function
        max_outsize=32,            # Maximum output size (32 bytes for uint256)
        is_static_call=True        # Ensure this is a static call
    )
    
    # Decode the response into a uint256
    return convert(response, uint256)