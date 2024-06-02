#pragma once

#include "product_group.hpp"

struct product
{
    static consteval auto table() { return "product"; }
    static consteval auto primary_key() { return &product::id; }

    struct id
    {
        static const constexpr auto c_name() { return "id"; }
        int32_t value;
    } id;

    struct group_id
    {
        static const constexpr auto c_name() { return "group_id"; }
        // static const constexpr auto nane() { return "Product group"; }
        int32_t value;
        static const constexpr auto foreign_key() { return &product_group::id; }
    } group_id;

    struct commodity
    {
        static const constexpr auto c_name() { return "commodity"; }
        std::string value;
    } commodity;

    struct risk_score
    {
        static const constexpr auto c_name() { return "risk_score"; }
        // static const constexpr auto name() { return "Risk Score"; }
        int8_t value;
    } risk_score; // 0 -> 10
};
