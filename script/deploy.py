from src import favorites, favorites_factory, five_more
from moccasin.boa_tools import VyperContract

def deploy_favorites() -> VyperContract:
    favorites_contract = favorites.deploy()
    return favorites_contract

def deploy_factory(favorites_contract: VyperContract):
    factory_contract: VyperContract = favorites_factory.deploy(favorites_contract.address)
    factory_contract.create_favorites_contract()

    new_favorites_address: str = factory_contract.list_of_favorites_contracts(0)
    new_favorites_contract: VyperContract = favorites.at(new_favorites_address)
    new_favorites_contract.store(50)
    print(f"Stored Value is: {new_favorites_contract.retrieve()}")

    factory_contract.store_from_factory(0, 100)
    print(f"New contract stored value is {new_favorites_contract.retrieve()}")
    print(f"Original contract stored value is {favorites_contract.retrieve()}")

def deploy_five_more():
    five_more_contract: VyperContract = five_more.deploy()
    five_more_contract.store(99)
    print(five_more_contract.retrieve())

def moccasin_main() -> VyperContract:
    favorites_contract = deploy_favorites()
    deploy_factory(favorites_contract)
    deploy_five_more()
    #return deploy_favorites()
