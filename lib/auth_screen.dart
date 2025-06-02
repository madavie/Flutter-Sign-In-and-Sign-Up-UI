import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen>
    with SingleTickerProviderStateMixin {
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
    final isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode ? Colors.grey[900] : Colors.grey[50],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: 40),
              // Logo
              Hero(
                tag: 'app-logo',
                child: Material(
                  color: Colors.transparent,
                  child: ShaderMask(
                    shaderCallback: (bounds) => LinearGradient(
                      colors: [colors.primary, colors.secondary],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ).createShader(bounds),
                    child: Text(
                      'JamesCodeLab',
                      style: theme.textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 22,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),

              // TabBar
              Container(
                decoration: BoxDecoration(
                  color: isDarkMode
                      ? Colors.grey[850]!.withOpacity(0.6)
                      : Colors.grey[100]!,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isDarkMode ? Colors.grey[800]! : Colors.grey[300]!,
                    width: 1.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(isDarkMode ? 0.2 : 0.05),
                      blurRadius: 16,
                      spreadRadius: 1,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(6),
                child: TabBar(
                  controller: _tabController,
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    gradient: LinearGradient(
                      colors: [colors.primary, colors.secondary],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: colors.primary.withOpacity(0.4),
                        blurRadius: 10,
                        spreadRadius: 1,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  indicatorSize: TabBarIndicatorSize.tab,
                  labelColor: Colors.white,
                  unselectedLabelColor:
                      isDarkMode ? Colors.grey[400] : Colors.grey[600],
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                    letterSpacing: 0.8,
                  ),
                  unselectedLabelStyle: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                  ),
                  splashFactory: NoSplash.splashFactory,
                  overlayColor: MaterialStateProperty.resolveWith<Color?>(
                    (Set<MaterialState> states) {
                      return states.contains(MaterialState.pressed)
                          ? colors.primary.withOpacity(0.1)
                          : null;
                    },
                  ),
                  tabs: const [
                    Tab(
                      text: 'Sign In',
                      iconMargin: EdgeInsets.only(bottom: 4),
                    ),
                    Tab(
                      text: 'Sign Up',
                      iconMargin: EdgeInsets.only(bottom: 4),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 28),

              // Forms
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [_buildSignInForm(theme), _buildSignUpForm(theme)],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSignInForm(ThemeData theme) {
    final isDarkMode = theme.brightness == Brightness.dark;

    return SingleChildScrollView(
      child: Column(
        children: [
          // Email field
          _buildTextField(
            theme: theme,
            controller: _emailController,
            labelText: 'Email',
            prefixIcon: Icons.email_outlined,
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 16),

          // Password field
          _buildTextField(
            theme: theme,
            controller: _passwordController,
            labelText: 'Password',
            prefixIcon: Icons.lock_outline,
            obscureText: _obscurePassword,
            suffixIcon: IconButton(
              icon: Icon(
                _obscurePassword ? Icons.visibility_off : Icons.visibility,
                color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
              ),
              onPressed: () {
                setState(() {
                  _obscurePassword = !_obscurePassword;
                });
              },
            ),
          ),
          const SizedBox(height: 8),

          // Remember me & Forgot password
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Remember me checkbox
              Row(
                children: [
                  Theme(
                    data: theme.copyWith(
                      unselectedWidgetColor:
                          isDarkMode ? Colors.grey[400] : Colors.grey[600],
                    ),
                    child: Transform.scale(
                      scale: 0.9,
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
                            return isDarkMode
                                ? Colors.grey[700]!
                                : Colors.grey[300]!;
                          },
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                        visualDensity: VisualDensity.compact,
                      ),
                    ),
                  ),
                  Text(
                    'Remember me',
                    style: TextStyle(
                      color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                      fontSize: 13,
                    ),
                  ),
                ],
              ),

              // Forgot password
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Text(
                  'Forgot password?',
                  style: TextStyle(
                    color: theme.colorScheme.secondary,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Sign In button
          _buildGradientButton(
              theme: theme, text: 'Sign In', onPressed: () {}),
          const SizedBox(height: 24),

          // Social Auth Section
          _buildSocialAuthSection(theme),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildSignUpForm(ThemeData theme) {
    final isDarkMode = theme.brightness == Brightness.dark;

    return SingleChildScrollView(
      child: Column(
        children: [
          // Name field
          _buildTextField(
            theme: theme,
            controller: _nameController,
            labelText: 'Full Name',
            prefixIcon: Icons.person_outline,
          ),
          const SizedBox(height: 16),

          // Email field
          _buildTextField(
            theme: theme,
            controller: _emailController,
            labelText: 'Email',
            prefixIcon: Icons.email_outlined,
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 16),

          // Password field
          _buildTextField(
            theme: theme,
            controller: _passwordController,
            labelText: 'Password',
            prefixIcon: Icons.lock_outline,
            obscureText: _obscurePassword,
            suffixIcon: IconButton(
              icon: Icon(
                _obscurePassword ? Icons.visibility_off : Icons.visibility,
                color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
              ),
              onPressed: () {
                setState(() {
                  _obscurePassword = !_obscurePassword;
                });
              },
            ),
          ),
          const SizedBox(height: 8),

          // Password strength indicator
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LinearProgressIndicator(
                value: 0.7,
                backgroundColor:
                    isDarkMode ? Colors.grey[800] : Colors.grey[200],
                color: Colors.greenAccent,
                minHeight: 4,
                borderRadius: BorderRadius.circular(2),
              ),
              const SizedBox(height: 6),
              Text(
                'Password strength: Medium',
                style: TextStyle(
                  color: isDarkMode ? Colors.grey[500] : Colors.grey[600],
                  fontSize: 12,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Sign Up button
          _buildGradientButton(
              theme: theme, text: 'Sign Up', onPressed: () {}),
          const SizedBox(height: 24),

          // Social Auth Section
          _buildSocialAuthSection(theme),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildSocialAuthSection(ThemeData theme) {
    final isDarkMode = theme.brightness == Brightness.dark;

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Divider(
                color: isDarkMode ? Colors.grey[700] : Colors.grey[300],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                'OR CONTINUE WITH',
                style: TextStyle(
                  color: isDarkMode ? Colors.grey[500] : Colors.grey[600],
                  fontSize: 12,
                  letterSpacing: 1.2,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Expanded(
              child: Divider(
                color: isDarkMode ? Colors.grey[700] : Colors.grey[300],
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),

        // Social buttons
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildSocialButton(
              iconPath: 'assets/icons/google.png',
              bgColor: isDarkMode ? Colors.grey[800]! : Colors.white,
              onPressed: () {},
              tooltip: 'Sign in with Google',
            ),
            const SizedBox(width: 20),
            _buildSocialButton(
              iconPath: 'assets/icons/apple.png',
              bgColor: isDarkMode ? Colors.grey[800]! : Colors.black,
              onPressed: () {},
              tooltip: 'Sign in with Apple',
            ),
            const SizedBox(width: 20),
            _buildSocialButton(
              iconPath: 'assets/icons/facebook.png',
              bgColor: isDarkMode ? Colors.grey[800]! : const Color(0xFF1877F2),
              onPressed: () {},
              tooltip: 'Sign in with Facebook',
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTextField({
    required ThemeData theme,
    required TextEditingController controller,
    required String labelText,
    required IconData prefixIcon,
    TextInputType? keyboardType,
    bool obscureText = false,
    Widget? suffixIcon,
  }) {
    final isDarkMode = theme.brightness == Brightness.dark;

    return TextField(
      controller: controller,
      style: TextStyle(color: isDarkMode ? Colors.white : Colors.black87),
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(
          color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
          fontSize: 14,
        ),
        floatingLabelStyle: TextStyle(
          color: theme.colorScheme.primary,
          fontSize: 14,
        ),
        prefixIcon: Icon(
          prefixIcon,
          color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
          size: 20,
        ),
        suffixIcon: suffixIcon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: isDarkMode ? Colors.grey[700]! : Colors.grey[300]!,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: isDarkMode ? Colors.grey[700]! : Colors.grey[300]!,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
              color: theme.colorScheme.primary, width: 1.5),
        ),
        filled: true,
        fillColor:
            isDarkMode ? Colors.grey[800]!.withOpacity(0.7) : Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 16,
        ),
      ),
      keyboardType: keyboardType,
      obscureText: obscureText,
    );
  }

  Widget _buildGradientButton({
    required ThemeData theme,
    required String text,
    required VoidCallback onPressed,
  }) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          width: double.infinity,
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: LinearGradient(
              colors: [theme.colorScheme.primary, theme.colorScheme.secondary],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: theme.colorScheme.primary.withOpacity(0.3),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: onPressed,
              splashColor: Colors.white.withOpacity(0.2),
              highlightColor: Colors.white.withOpacity(0.1),
              child: Center(
                child: Text(
                  text,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSocialButton({
    required String iconPath,
    required VoidCallback onPressed,
    required Color bgColor,
    String? tooltip,
  }) {
    return Tooltip(
      message: tooltip ?? '',
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: onPressed,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 56,
            height: 56,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: bgColor,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Image.asset(
              iconPath,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}