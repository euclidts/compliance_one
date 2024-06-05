#pragma once

#include "product_group.hpp"

struct product
{
    static consteval auto table() { return "product"; }
    static consteval auto primary_key() { return &product::id; }

    struct id
    {
        static consteval auto c_name() { return "id"; }
        int32_t value;
    } id;

    struct group_id
    {
        static consteval auto c_name() { return "group_id"; }
        // static consteval auto nane() { return "Product group"; }
        int32_t value;
        static consteval auto foreign_key() { return &product_group::id; }
    } group_id;

    struct commodity
    {
        static consteval auto c_name() { return "commodity"; }
        std::string value;
    } commodity;

    struct risk_score
    {
        static consteval auto c_name() { return "risk_score"; }
        // static consteval auto name() { return "Risk Score"; }
        int8_t value;
    } risk_score; // 0 -> 10
};
