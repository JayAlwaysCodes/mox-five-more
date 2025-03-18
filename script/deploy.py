from src import favorites, favorites_factory
from moccasin.boa_tools import VyperContract

def deploy_favorites() -> VyperContract:
    favorites_contract = favorites.deploy()
    return favorites_contract

def deploy_factory(favorites_contract: VyperContract):
    factory_contract: VyperContract = favorites_factory.deploy(favorites_contract.address)
    factory_contract.create_favorites_contract()

    new_favorites_address: str = factory_contract.list_of_favorite_contracts(0)
    new_favorites_contract: VyperContract = favorites.at(new_favorites_address)
    new_favorites_contract.store(50)
    print(f"Stored Value is: {new_favorites_contract.retrieve()}")

def moccasin_main() -> VyperContract:
    favorites_contract = deploy_favorites()
    deploy_factory(favorites_contract)
    return deploy_favorites()
