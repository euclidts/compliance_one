#pragma once

#include "ctp_group.hpp"

struct ctp_type
{
    static const constexpr auto table() { return "ctp_type"; }
    static const constexpr auto primary_key() { return &ctp_type::id; }

    struct id
    {
        static const constexpr auto c_name() { return "id"; }
        int32_t value{0};
    } id;

    struct group_id
    {
        static const constexpr auto c_name() { return "group_id"; }
        int32_t value{0};
        static const constexpr auto foreign_key() { return &ctp_group::id; }
    } group_id;

    struct type_name
    {
        static const constexpr auto c_name() { return "name"; }
        std::string value{};
    } type_name;

    struct notes
    {
        static const constexpr auto c_name() { return "notes"; }
        std::string value{};
    } notes;

    struct risk_score
    {
        static const constexpr auto c_name() { return "risk_score"; }
        int8_t value{};
    } risk_score;
};
