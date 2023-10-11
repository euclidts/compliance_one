#pragma once

#include "product_group.hpp"

struct product
{
    static const constexpr auto table() { return "product"; }

    struct primary_key
    {
        static const constexpr auto c_name() { return "id"; }
        int32_t value{0};
    } primary_key;

    struct group_id
    {
        static const constexpr auto c_name() { return "group_id"; }
        static const constexpr auto nane() { return "Product group"; }
        int32_t value{0};
        static const constexpr auto froeign_key() { return &product_group::primary_key; }
    } group_id;

    struct commodity
    {
        static const constexpr auto c_name() { return "commodity"; }
        std::string value{};
    } commodity;

    struct risk_score
    {
        static const constexpr auto c_name() { return "risk_score"; }
        static const constexpr auto name() { return "Risk Score"; }
        int8_t value{1};
    } risk_score;
};
