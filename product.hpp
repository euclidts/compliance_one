#include <cstdint>
#include <string>

#include <product_group.hpp>

struct product
{
    static consteval auto table() { return "product"; };

    struct id
    {
        static consteval auto c_nane() { return "id"; };
        int32_t value{0};
        static consteval auto property() { return "primary"; };
    } id;

    struct group_id
    {
        static consteval auto c_nane() { return "product_group"; };
        int32_t value{0};
        static consteval auto references() { return &product_group::id; };
        static consteval auto property() { return "unique"; };
    } group_id;

    struct commodity
    {
        static consteval auto c_name() { return "commodity"; };
        std::string value{};
    } commodity;

    struct risk_score
    {
        static consteval auto c_name() { return "risk_score"; };
        static consteval auto name() { return "Risk Score"; };
        int value{};
    } risk_score;
};
