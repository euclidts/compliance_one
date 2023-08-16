#include <cstdint>
#include <chrono>

#include <sovereignty.hpp>

struct vessel
{
    static consteval auto table() { return "country"; };

    struct id
    {
        static consteval auto c_nane() { return "id"; };
        int32_t value{0};
        static consteval auto property() { return "primary"; };
    } id;

    struct country_name
    {
        static consteval auto c_name() { return "country_name"; };
        static consteval auto name() { return "Country name"; };
        std::string value{};
    } country_name;

    struct official_state_name
    {
        static consteval auto c_name() { return "official_state_name"; };
        static consteval auto name() { return "Official state name"; };
        std::string value{};
    } official_state_name;

    struct sovereignty_id
    {
        static consteval auto c_name() { return "sovereignty_id"; };
        int32_t value{};
        static consteval auto froeign_key() { return &sovereignty::id; };
    } sovereignty_id;
};
