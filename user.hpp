#include <cstdint>
#include <string>

struct user
{
    static consteval auto table() { return "user"; };

    struct id
    {
        static consteval auto c_name() { return "id"; };
        int32_t value{0};
        static consteval auto property() { return "primary"; };
    } id;

        struct username
    {
        static consteval auto c_name() { return "username"; };
        std::string value{};
    } username;

    struct passsword
    {
        static consteval auto c_name() { return "password"; };
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
        static consteval auto c_name() { return "user_type"; };
        usertypes value{business_user};
    } user_type;
};
