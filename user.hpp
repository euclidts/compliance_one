#include <cstdint>
#include <string>

struct user
{
    static const constexpr auto table() { return "user"; }
    static const constexpr auto primary_key() { return &user::id; }
    static const constexpr auto session_id() { return &user::m_session_id; }

    struct id
    {
        static const constexpr auto c_name() { return "id"; }
        int32_t value{0};
    } id;

    struct username
    {
        static const constexpr auto c_name() { return "username"; }
        std::string value{};
    } username;

    struct passsword
    {
        static const constexpr auto c_name() { return "password"; }
        std::string value{};
    } password;
    
    enum usertypes
    {
        business_user,
        compliance_user,
        manager,
        admin,
        technical_admin
    };

    struct user_type
    {
        static const constexpr auto c_name() { return "user_type"; }
        usertypes value{business_user};
    } user_type;

    struct m_session_id
    {
        static const constexpr auto c_name() { return "session_id"; }
        std::string value{};
    } m_session_id;
};
