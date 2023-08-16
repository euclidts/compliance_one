#include <cstdint>
#include <string>

struct counterparty_group
{
    static consteval auto table() { return "counterparty_group"; };

    struct id
    {
        static consteval auto c_nane() { return "id"; };
        int32_t value{0};
        static consteval auto property() { return "primary"; };
    } id;

    struct group_name
    {
        static consteval auto c_name() { return "name"; };
        std::string value{};
    } group_name;
};
