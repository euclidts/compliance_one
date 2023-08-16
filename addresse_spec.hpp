#include <string>

struct address_spec
{
    static consteval auto c_name() { return "address"; };

    struct address
    {
        static consteval auto c_name() { return "address"; };
        std::string value{};
    } address;

    struct county
    {
        static consteval auto c_name() { return "country"; };
        std::string value{};
    } county;

    struct zip
    {
        static consteval auto c_name() { return "zip"; };
        static consteval auto name() { return "Zip Code"; };
        std::string value{};
    } zip;

    struct location
    {
        static consteval auto c_name() { return "location"; };
        std::string value{};
    } location;
};
