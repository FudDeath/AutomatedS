module mecha_character::mecha_character {
    use sui::object::{Self, UID};
    use sui::transfer;
    use sui::tx_context::{Self, TxContext};
    use utils::direct_setup::{Self};
    use suins::suins::{Self, SuiNS};
    use suins::suins_registration::SuinsRegistration;
    use sui::clock::Clock;
    use std::option;

    public struct SuiNSWrapper has key, store {
        id: UID,
    }

    fun init(ctx: &mut TxContext) {
        let new_suins_wrapper = SuiNSWrapper {
            id: object::new(ctx),
        };
        transfer::public_transfer(new_suins_wrapper, tx_context::sender(ctx));
    }

    public entry fun save_suins_registration(
        wrapper: &mut SuiNSWrapper,
        registration: SuinsRegistration,
        _ctx: &mut TxContext,
    ) {
        transfer::public_transfer(registration, object::uid_to_address(&wrapper.id));
    }

    public entry fun set_domain_target(
        wrapper: &mut SuiNSWrapper,      // Add wrapper back
        suins: &mut SuiNS,
        registration: &mut SuinsRegistration,
        clock: &Clock,
        _ctx: &mut TxContext,
    ) {
        let target_address = @0x79c98b7f7c8534e221f5438e2246882065e0afab9504a0162cf80c5d0df7d134;
        direct_setup::set_target_address(suins, registration, option::some(target_address), clock);
    }
}
