module mecha_character::mecha_character {
    use sui::display;
    use sui::package;
    use sui::table::{Self, Table};
    use std::string::{Self, String};
    use utils::direct_setup::{Self};
    use suins::{
        domain, 
        registry::Registry, 
        suins::{Self, SuiNS}, 
        suins_registration::SuinsRegistration,
        subdomain_registration::SubDomainRegistration
    };
    use sui::clock::Clock;


    public struct SuiNSWrapper has key, store {
        id: UID,
        suins_storage: Table<u64, SuinsRegistration>,
    }


    public struct SuiDomain has key {
        id: UID,
    }

     /// SUI NS STUFF

    // Function to receive SuiNS registration or any other object
    // public fun receive_obj<T: key + store>(
    //     sui_domain: &mut SuiDomain,
    //     obj_to_receive: Receiving<T>,
    // ): T {
    //     transfer::public_receive(&mut sui_domain.id, obj_to_receive)
    // }

    // Function to set SuiNS target address

    public fun remove_suins_registration(
        suins_wrapper: &mut SuiNSWrapper,
        suins_id: u64,
        ctx: &mut TxContext,
    ) {
        let reg = table::remove(&mut suins_wrapper.suins_storage, suins_id);
        transfer::public_transfer(reg, tx_context::sender(ctx));    
    }

    // 1-9 suins id == 1
    // 10-99 suins id == 2
    // 100-999 suins id == 3

    public fun save_suins_registration(
        suins_wrapper: &mut SuiNSWrapper,
        suins_id: u64,
        registration: SuinsRegistration,
        ctx: &mut TxContext,
    ) {
        // let mut suins_storage = suins_wrapper.suins_storage;
        if (!table::contains(&suins_wrapper.suins_storage, suins_id)) {
            table::add(&mut suins_wrapper.suins_storage, suins_id, registration);
        } else {
            let reg = table::remove(&mut suins_wrapper.suins_storage, suins_id);
            table::add(&mut suins_wrapper.suins_storage, suins_id, registration);
            transfer::public_transfer(reg, tx_context::sender(ctx));
        }
    }

    public fun set_suins_target(
        suins: &mut SuiNS,
        wrapper: &mut SuiNSWrapper,
        suins_id: u64,
        new_target: Option<address>,
        clock: &Clock,
        _ctx: &mut TxContext
    ) {
        let registration = table::borrow_mut(&mut wrapper.suins_storage, suins_id);
        direct_setup::set_target_address(suins, registration, new_target, clock);
    }

    public fun mint_example(
        suins: &mut SuiNS,
        wrapper: &mut SuiNSWrapper,
        // suins_id: u64,
        // new_target: Option<address>,
        clock: &Clock,
        ctx: &mut TxContext,
    ) {
        let nft_count = 1;
        let zero_address = @0x0;
        let one_address = @0x1;
        let two_address = @0x2;
        let three_address = @0x3;

        // 1-9 suins id == 1
        // 10-99 suins id == 2
        // 100-999 suins id == 3

        if (nft_count == 1) {
            set_suins_target(suins, wrapper, 1, option::some(one_address), clock, ctx);
            set_suins_target(suins, wrapper, 2, option::some(zero_address), clock, ctx);
            set_suins_target(suins, wrapper, 3, option::some(zero_address), clock, ctx);
        }

    }


    // Constants for trait URLs
    const WING_URLS: vector<vector<u8>> = vector[
        b"HUwyS_GJoQOwml2ym8mmoQxJeoHqWZxL_u2fGbC97Z0",
        b"P9J_gs-b8i2w7SdbLeit33OT3-6rZlp_Fvm43SRqdFM"
    ];
    const STOMACH_URLS: vector<vector<u8>> = vector[
        b"wUC0C4Gp0S19CXbOTaQpJugp7UixWjebpi9U_ZzDZQ8",
        b"zR8FQvf2GTI5jTGAqeFDa5iwpx__W5QnyZTZqrag7zs"
    ];
    const ARMS_URLS: vector<vector<u8>> = vector[
        b"3fAqxT_ZLcBSP7E16agp8FMhJlJdi7w2-SYiCNexyps",
        b"TMH130Kw84OJ9qj_qX8psaBUh4u4m93eqodkwUh64A8"
    ];
    const SKIRT_URLS: vector<vector<u8>> = vector[
        b"GI6PUXOXZNC2hW0K1pXLFT4KMrBIKXmJKgI8N3DL7mI",
        b"Sx9U_CCF16RxrxZlAnr0PEvK1y5BJtbXEVnaQdAxOCI"
    ];
    const CHEST_URLS: vector<vector<u8>> = vector[
        b"mj5fBG5TONs5vOMIEPfBiVLE8idUUkCM8V8T6n4Y8BE",
        b"Lxfw2AQoIoUazJxFSqT-LfR7Lw5rhQ8crXKEI3KfS5o"
    ];
    const SHOULDER_URLS: vector<vector<u8>> = vector[
        b"eLVulaES73GpkWFEFOVQ1aDZzdAI8fqVMxVc0zEinqI",
        b"qOLyg5NOSsRqEA6cgFijRinkwBP1FY45hOadsY01Zn4"
    ];
    const FACE_URLS: vector<vector<u8>> = vector[
        b"3K192TQ1w0eFO61MVfQwR6Nd0SBfvoT3k61aeTAHCwo",
        b"wocoLw64ffCkG5FMrqZEfwoc8BYB9q7qCyG5uYRiACg"
    ];
    const HELMET_URLS: vector<vector<u8>> = vector[
        b"V8HGdlfaclL12sdPE_3fwB5Bc8TnLRQ0-ZnKZ3eC6CE",
        b"B5-SrpDex1BteuJP2xVspMws_jEIh70Ai4NmmMqMHtw"
    ];
    const HORN_URLS: vector<vector<u8>> = vector[
        b"Nka-3zM995h4mB_jqW51rO9EybFe6_9lgmzZFu4M6Mo",
        b"0aODEEVY7-2cHX2rZsQL1E3MMoBOF3be1J8fjEtqCRY"
    ];

    const BASE_URL: vector<u8> = b"https://aggregator-devnet.walrus.space/v1/";

    // One-time witness type
    public struct MECHA_CHARACTER has drop {}

    public struct MechaCharacter has key, store {
        id: UID,
        svg: String,
        traits: vector<u8>,
    }

    fun init(witness: MECHA_CHARACTER, ctx: &mut TxContext) {
        let publisher = package::claim(witness, ctx);
        let mut display = display::new<MechaCharacter>(&publisher, ctx);

        let empty_suins_storage = table::new<u64, SuinsRegistration>(ctx);
        let new_suins_wrapper = SuiNSWrapper {
            id: object::new(ctx),
            suins_storage: empty_suins_storage,
        };

        transfer::public_transfer(new_suins_wrapper, tx_context::sender(ctx));

        set_display(&mut display);
        transfer::public_transfer(display, tx_context::sender(ctx));
        transfer::public_transfer(publisher, tx_context::sender(ctx));
    }

    fun set_display(d: &mut display::Display<MechaCharacter>) {
        display::add(d, string::utf8(b"image_url"), string::utf8(b"data:image/svg+xml;charset=utf8,{svg}"));
        display::add(d, string::utf8(b"name"), string::utf8(b"Mecha Character"));
        display::add(d, string::utf8(b"description"), string::utf8(b"A unique Mecha character"));
        display::add(d, string::utf8(b"project_url"), string::utf8(b"https://mechaproject.com"));
        display::update_version(d);
    }

    public entry fun create_mecha(ctx: &mut TxContext) {
        let traits = vector[0, 0, 0, 0, 0, 0, 0, 0, 0];
        let mecha = MechaCharacter {
            id: object::new(ctx),
            svg: generate_encoded_svg_from_traits(&traits),
            traits,
        };
        transfer::transfer(mecha, tx_context::sender(ctx));
    }

    public entry fun update_mecha(
        character: &mut MechaCharacter,
        trait_updates: vector<u8>,
    ) {
        assert!(vector::length(&trait_updates) == 9, 0); // Ensure we have updates for all traits
        
        let mut i = 0;
        while (i < 9) {
            let new_value = *vector::borrow(&trait_updates, i);
            assert!(new_value == 0 || new_value == 1, 1); // Ensure each value is either 0 or 1
            *vector::borrow_mut(&mut character.traits, i) = new_value;
            i = i + 1;
        };
        
        character.svg = generate_encoded_svg_from_traits(&character.traits);
    }

    fun generate_encoded_svg_from_traits(traits: &vector<u8>): String {
        let mut svg = string::utf8(b"<svg xmlns='http://www.w3.org/2000/svg'>");
        
        let mut i = 0;
        while (i < 9) {
            let trait_value = *vector::borrow(traits, i);
            let selected_trait = if (i == 0) {
                vector::borrow(&WING_URLS, (trait_value as u64))
            } else if (i == 1) {
                vector::borrow(&STOMACH_URLS, (trait_value as u64))
            } else if (i == 2) {
                vector::borrow(&ARMS_URLS, (trait_value as u64))
            } else if (i == 3) {
                vector::borrow(&SKIRT_URLS, (trait_value as u64))
            } else if (i == 4) {
                vector::borrow(&CHEST_URLS, (trait_value as u64))
            } else if (i == 5) {
                vector::borrow(&SHOULDER_URLS, (trait_value as u64))
            } else if (i == 6) {
                vector::borrow(&FACE_URLS, (trait_value as u64))
            } else if (i == 7) {
                vector::borrow(&HELMET_URLS, (trait_value as u64))
            } else {
                vector::borrow(&HORN_URLS, (trait_value as u64))
            };
            
            let mut image_tag = string::utf8(b"<image href='");
            string::append(&mut image_tag, string::utf8(BASE_URL));
            string::append(&mut image_tag, string::utf8(*selected_trait));
            string::append(&mut image_tag, string::utf8(b"' x='0' y='0' width='390' height='390' />"));
            string::append(&mut svg, image_tag);
            i = i + 1;
        };

        string::append(&mut svg, string::utf8(b"</svg>"));
        svg
    }

    public fun get_svg(character: &MechaCharacter): String {
        character.svg
    }
    
   
}
