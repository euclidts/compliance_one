#pragma once

#include <cstdint>

struct region
{
    static consteval auto table() { return "region"; }
    static consteval auto primary_key() { return &region::id; }

    struct id
    {
        static consteval auto c_name() { return "id"; };
        uint32_t value;
    } id;

    struct name
    {
        static consteval auto c_name() { return "name"; }
        std::string value;
    } name;

    struct wikiDataId
    {
        static consteval auto c_name() { return "wikiDataId"; }
        std::string value;
    } wikiDataId;
};
