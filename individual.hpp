#include <cstdint>
#include <chrono>

#include <contact.hpp>
#include <address_spec.hpp>

struct individual
{
    static consteval auto table() { return "individual"; };

    struct id
    {
        static consteval auto c_nane() { return "id"; };
        int32_t value{0};
        static consteval auto property() { return "primary"; };
    } id;

    struct contact_id
    {
        static consteval auto c_nane() { return "contact_id"; };
        int32_t value{0};
        static consteval auto property() { return "unique"; };
        static consteval auto references() { return &contact::id; };
    } contact_id;
    
    enum roles
    {
        owner,
        director,
        intermediary,
        other
    };

    struct role
    {
        static consteval auto c_name() { return "role"; };
        roles value{};
    } role;

    // KYC 
    // counteparty information
    // accesible to all users

    struct uuid
    {
        static consteval auto c_name() { return "individual_unique_identifier"; };
        static consteval auto name() { return "Individual Unique Identifier"; };
        std::string value{};
    } uuid;

    struct local_name
    {
        static consteval auto c_name() { return "local_name"; };
        static consteval auto name() { return "Name (Local Characters)"; };
        std::string value{};
    } local_name;

    struct local_forenames
    {
        static consteval auto c_name() { return "local_forenames"; };
        static consteval auto name() { return "Forenames (Local Characters)"; };
        std::string value{};
    } local_forenames;

    address_spec address;

    struct date_of_birth
    {
        static consteval auto c_name() { return "date_of_birth"; };
        static consteval auto name() { return "Date of Birth"; };
        std::chrono::year_month_day value{};
    } date_of_birth;

    struct pep
    {
        static consteval auto c_name() { return "pep"; };
        static consteval auto name() { return "Is a PEP"; };
        bool value{};
    } pep;

    struct pep_country
    {
        static consteval auto c_name() { return "pep_country"; };
        static consteval auto name() { return "Country"; };
        bool value{};
    } pep_country;

    struct pep_notes
    {
        static consteval auto c_name() { return "pep_notes"; };
        static consteval auto name() { return "Additional Notes"; };
        std::string value{};
    } pep_notes;

    // only accesible to compliance users
    struct notes
    {
        static consteval auto c_name() { return "notes"; };
        std::string value{};
    } notes;
};
