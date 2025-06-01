import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _obscurePassword = true;
  bool _rememberMe = false;

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    super.dispose();
  }

 @override
Widget build(BuildContext context) {
  final theme = Theme.of(context);
  final colors = theme.colorScheme;

  return Scaffold(
    backgroundColor: Colors.grey[900],
    body: SafeArea(
      child: Column(
        children: [
          const SizedBox(height: 40),
          // Logo
          ShaderMask(
            shaderCallback: (bounds) => LinearGradient(
              colors: [colors.primary, colors.secondary],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ).createShader(bounds),
            child: Text(
              'MyApp',
              style: theme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 32,
              ),
            ),
          ),
          const SizedBox(height: 40),

          // TabBar
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 24),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.3),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey[800]!),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            padding: const EdgeInsets.all(4),
            child: TabBar(
              controller: _tabController,
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                gradient: LinearGradient(
                  colors: [colors.primary, colors.secondary],
                ),
              ),
              labelColor: Colors.white,
              unselectedLabelColor: Colors.grey[400],
              tabs: const [
                Tab(text: 'Sign In'),
                Tab(text: 'Sign Up'),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Flexible space for forms and social buttons
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildAuthContent(context, _buildSignInForm(theme)),
                _buildAuthContent(context, _buildSignUpForm(theme)),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
  Widget _buildAuthContent(BuildContext context, Widget formContent) {
  return SingleChildScrollView(
    padding: const EdgeInsets.symmetric(horizontal: 24),
    child: Column(
      children: [
        formContent,
        // Social Auth Section
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 24),
          child: Row(
            children: [
              Expanded(child: Divider(color: Colors.grey[700])),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Text(
                  'OR CONTINUE WITH',
                  style: TextStyle(
                    color: Colors.grey[500],
                    fontSize: 12,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
              Expanded(child: Divider(color: Colors.grey[700])),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildSocialButton(
              icon: 'assets/icons/google.svg',
              bgColor: Colors.white,
              onPressed: () {},
            ),
            const SizedBox(width: 20),
            _buildSocialButton(
              icon: 'assets/icons/apple.svg',
              bgColor: Colors.black,
              iconColor: Colors.white,
              onPressed: () {},
            ),
            const SizedBox(width: 20),
            _buildSocialButton(
              icon: 'assets/icons/facebook.svg',
              bgColor: const Color(0xFF1877F2),
              iconColor: Colors.white,
              onPressed: () {},
            ),
          ],
        ),
        const SizedBox(height: 20),
      ],
    ),
  );
}


  Widget _buildSignInForm(ThemeData theme) {
    return Column(
      children: [
        TextField(
          controller: _emailController,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            labelText: 'Email',
            labelStyle: TextStyle(color: Colors.grey[400]),
            prefixIcon: Icon(Icons.email_outlined, color: Colors.grey[400]),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey[700]!),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey[700]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: theme.colorScheme.primary),
            ),
            filled: true,
            fillColor: Colors.grey[800],
          ),
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: 16),
        TextField(
          controller: _passwordController,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            labelText: 'Password',
            labelStyle: TextStyle(color: Colors.grey[400]),
            prefixIcon: Icon(Icons.lock_outline, color: Colors.grey[400]),
            suffixIcon: IconButton(
              icon: Icon(
                _obscurePassword ? Icons.visibility_off : Icons.visibility,
                color: Colors.grey[400],
              ),
              onPressed: () {
                setState(() {
                  _obscurePassword = !_obscurePassword;
                });
              },
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey[700]!),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey[700]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: theme.colorScheme.primary),
            ),
            filled: true,
            fillColor: Colors.grey[800],
          ),
          obscureText: _obscurePassword,
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Theme(
                  data: theme.copyWith(
                    unselectedWidgetColor: Colors.grey[400],
                  ),
                  child: Checkbox(
                    value: _rememberMe,
                    onChanged: (value) {
                      setState(() {
                        _rememberMe = value!;
                      });
                    },
                    fillColor: MaterialStateProperty.resolveWith<Color>(
                      (states) {
                        if (states.contains(MaterialState.selected)) {
                          return theme.colorScheme.primary;
                        }
                        return Colors.grey[700]!;
                      },
                    ),
                  ),
                ),
                Text(
                  'Remember me',
                  style: TextStyle(color: Colors.grey[400]),
                ),
              ],
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                'Forgot password?',
                style: TextStyle(color: theme.colorScheme.secondary),
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        Container(
          width: double.infinity,
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: LinearGradient(
              colors: [
                theme.colorScheme.primary,
                theme.colorScheme.secondary,
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: theme.colorScheme.primary.withOpacity(0.3),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              'Sign In',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSignUpForm(ThemeData theme) {
    return Column(
      children: [
        TextField(
          controller: _nameController,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            labelText: 'Full Name',
            labelStyle: TextStyle(color: Colors.grey[400]),
            prefixIcon: Icon(Icons.person_outline, color: Colors.grey[400]),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey[700]!),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey[700]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: theme.colorScheme.primary),
            ),
            filled: true,
            fillColor: Colors.grey[800],
          ),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: _emailController,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            labelText: 'Email',
            labelStyle: TextStyle(color: Colors.grey[400]),
            prefixIcon: Icon(Icons.email_outlined, color: Colors.grey[400]),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey[700]!),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey[700]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: theme.colorScheme.primary),
            ),
            filled: true,
            fillColor: Colors.grey[800],
          ),
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: 16),
        TextField(
          controller: _passwordController,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            labelText: 'Password',
            labelStyle: TextStyle(color: Colors.grey[400]),
            prefixIcon: Icon(Icons.lock_outline, color: Colors.grey[400]),
            suffixIcon: IconButton(
              icon: Icon(
                _obscurePassword ? Icons.visibility_off : Icons.visibility,
                color: Colors.grey[400],
              ),
              onPressed: () {
                setState(() {
                  _obscurePassword = !_obscurePassword;
                });
              },
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey[700]!),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey[700]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: theme.colorScheme.primary),
            ),
            filled: true,
            fillColor: Colors.grey[800],
          ),
          obscureText: _obscurePassword,
        ),
        const SizedBox(height: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LinearProgressIndicator(
              value: 0.7,
              backgroundColor: Colors.grey[800],
              color: Colors.greenAccent,
              minHeight: 4,
              borderRadius: BorderRadius.circular(2),
            ),
            const SizedBox(height: 8),
            Text(
              'Password strength: Medium',
              style: TextStyle(
                color: Colors.grey[500],
                fontSize: 12,
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        Container(
          width: double.infinity,
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: LinearGradient(
              colors: [
                theme.colorScheme.primary,
                theme.colorScheme.secondary,
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: theme.colorScheme.primary.withOpacity(0.3),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              'Sign Up',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSocialButton({
    required String icon,
    required VoidCallback onPressed,
    Color bgColor = Colors.white,
    Color iconColor = Colors.black,
  }) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(50),
      child: Container(
        width: 56,
        height: 56,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: bgColor,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: SvgPicture.asset(
          icon,
          colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
        ),
      ),
    );
  }
}