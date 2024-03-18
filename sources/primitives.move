address 0xCAFE {
module PrimitivesTutorial {
        struct ExampleData has key {
        number: u64,
        status: bool,
        address: address,
        note: string::String,
    }
    public entry fun create_example_data(account: &signer, initial_number: u64, note: string::String) {
        move_to(account, ExampleData {
            number: initial_number,
            status: true,
            address: signer::address_of(account),
            note,
        });
    }
    #[view]
    public fun get_number(account: &signer): u64 acquires ExampleData {
        borrow_global<ExampleData>(signer::address_of(account)).number
    }
     public fun increment_number(account: &signer, increment: u64) acquires ExampleData {
        let example_data = borrow_global_mut<ExampleData>(signer::address_of(account));
        example_data.number = example_data.number + increment;
    }
    public fun toggle_status(account: &signer) acquires ExampleData {
        let example_data = borrow_global_mut<ExampleData>(signer::address_of(account));
        example_data.status = !example_data.status;
    }
    public fun is_even(number: u64): bool {
        number % 2 == 0
    }
    #[test(account = @0xBEEF)]
    public fun test_create_and_get_example_data(account: &signer) acquires ExampleData {
        let initial_number = 25;
        let note = string::utf8(b"Hello there");
        create_example_data(account, initial_number, note);

        let example_data_number = get_number(account);
        if (example_data_number != initial_number) {
            abort 42
        }
    }
}
}