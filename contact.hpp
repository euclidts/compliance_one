#include <cstdint>
#include <chrono>

#include <address_spec.hpp>

struct contact
{
    static consteval auto table() { return "contact"; };

    struct id
    {
        static consteval auto c_nane() { return "id"; };
        int32_t value{0};
        static consteval auto property() { return "primary"; };
    } id;

    struct family_name
    {
        static consteval auto c_name() { return "family_name"; };
        static consteval auto name() { return "Family Name (Latin script)"; };
        std::string value{};
    } name;

    struct forenames
    {
        static consteval auto c_name() { return "forenames"; };
        static consteval auto name() { return "Forenames (Latin script)"; };
        std::string value{};
    } forenames;

    struct email
    {
        static consteval auto c_name() { return "email"; };
        std::string value{};
    } email;

    struct phone
    {
        static consteval auto c_name() { return "phone"; };
        std::string value{};
    } phone;
};
