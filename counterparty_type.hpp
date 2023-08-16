#include <cstdint>
#include <string>

#include <counterparty_group.hpp>

struct counterparty_type
{
    static consteval auto table() { return "counterparty_type"; };

    struct id
    {
        static consteval auto c_nane() { return "id"; };
        int32_t value{0};
        static consteval auto property() { return "primary"; };
    } id;

    struct group_id
    {
        static consteval auto c_nane() { return "counterparty_group"; };
        int32_t value{0};
        static consteval auto foreign_key() { return &counterparty_group::id; };
    } group_id;

    struct type_name
    {
        static consteval auto c_name() { return "type_name"; };
        static consteval auto name() { return "Counterparty Type"; };
        std::string value{};
    } type_name;

    struct notes
    {
        static consteval auto c_name() { return "notes"; };
        std::string value{};
    } notes;

    struct risk_score
    {
        static consteval auto c_name() { return "risk_score"; };
        static consteval auto name() { return "Risk Score (1-10)"; };
        int value{};
    } risk_score;
};
