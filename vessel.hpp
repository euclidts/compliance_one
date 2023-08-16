#include <cstdint>
#include <string>

struct vessel
{
    static consteval auto table() { return "vessel"; };

    struct id
    {
        static consteval auto c_nane() { return "id"; };
        int32_t value{0};
        static consteval auto property() { return "primary"; };
    } id;

    // KYC 
    // Vessel information
    // accesible to all users

    struct imo
    {
        static consteval auto c_name() { return "imo"; };
        static consteval auto name() { return "IMO"; };
        std::string value{};
    } imo;

    struct vessel_name
    {
        static consteval auto c_name() { return "name"; };
        std::string value{};
    } vessel_name;

    // owner --- link to company
    // manager --- link to company
    // restrictions Flag
};
