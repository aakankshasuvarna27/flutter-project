import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const WeddingPlannerApp());
}

class WeddingPlannerApp extends StatelessWidget {
  const WeddingPlannerApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wedding Planner Dashboard',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginPage(),
    );
  }
}

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        backgroundColor: Colors.purple[100],
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: LoginForm(),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          TextFormField(
            controller: _emailController,
            decoration: const InputDecoration(labelText: 'Email'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
              }
              return null;
            },
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: _usernameController,
            decoration: const InputDecoration(labelText: 'Username'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your username';
              }
              return null;
            },
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: _passwordController,
            decoration: const InputDecoration(labelText: 'Password'),
            obscureText: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your password';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                // Perform login/signup action
                // For simplicity, let's navigate to the dashboard directly
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const Dashboard()),
                );
              }
            },
            child: const Text('Login / Signup'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}

class OptionItem {
  final String name;
  final String imageUrl;

  OptionItem({required this.name, required this.imageUrl});
}

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wedding Planner Dashboard'),
        backgroundColor: Colors.purple[100],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // Logo
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Image.asset(
                'wed_img.png',
                height: 150,
                width: 150,
              ),
            ),
            // Cards
            buildCard(
              context,
              title: 'Manage Events',
              icon: Icons.calendar_today,
              onTap: () {
                // Navigate to event management page
              },
            ),
            const SizedBox(height: 10),
            buildCard(
              context,
              title: 'Venues',
              icon: Icons.location_on,
              onTap: () {
                // Navigate to venues page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const VenuesPage()),
                );
              },
            ),
            const SizedBox(height: 10),
            buildCard(
              context,
              title: 'Catering',
              icon: Icons.restaurant,
              onTap: () {
                // Navigate to catering page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CateringPage()),
                );
              },
            ),
            const SizedBox(height: 10),
            buildCard(
              context,
              title: 'Invitation',
              icon: Icons.mail,
              onTap: () {
                // Navigate to invitation types page
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const InvitationPage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCard(BuildContext context,
      {required String title,
      required IconData icon,
      required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Icon(icon,
                  size: 32, color: const Color.fromARGB(255, 207, 133, 220)),
              const SizedBox(width: 20),
              Text(
                title,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              const Icon(Icons.arrow_forward),
            ],
          ),
        ),
      ),
    );
  }
}

class VenuesPage extends StatelessWidget {
  const VenuesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Venues'),
        backgroundColor: Colors.purple[100],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const Text(
              'Choose Venue Type:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            buildOptionCard(
              context,
              title: 'Destination Wedding',
              imageUrl: 'destination_wedding.jpg',
            ),
            const SizedBox(height: 10),
            buildOptionCard(
              context,
              title: 'Intimate Wedding',
              imageUrl: 'intimate_wedding.jpg',
            ),
            const SizedBox(height: 10),
            buildOptionCard(
              context,
              title: 'Banquet Wedding',
              imageUrl: 'banquet_wedding.jpg',
            ),
          ],
        ),
      ),
    );
  }

  Widget buildOptionCard(BuildContext context,
      {required String title, required String imageUrl}) {
    return InkWell(
      onTap: () {
        // Handle option selection here
      },
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                imageUrl,
                height: 150,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 10),
              Text(
                title,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CateringPage extends StatelessWidget {
  const CateringPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Catering'),
        backgroundColor: Colors.purple[100],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const Text(
              'Choose Catering Type:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            buildOptionCard(
              context,
              title: 'Buffet Catering',
              imageUrl: 'buffet_catering.jpg',
            ),
            const SizedBox(height: 10),
            buildOptionCard(
              context,
              title: 'Plated Catering',
              imageUrl: 'plated_catering.jpg',
            ),
            const SizedBox(height: 10),
            buildOptionCard(
              context,
              title: 'Family Style Catering',
              imageUrl: 'family_style_catering.jpg',
            ),
          ],
        ),
      ),
    );
  }

  Widget buildOptionCard(BuildContext context,
      {required String title, required String imageUrl}) {
    return InkWell(
      onTap: () {
        // Handle option selection here
      },
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                imageUrl,
                height: 150,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 10),
              Text(
                title,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class InvitationPage extends StatelessWidget {
  const InvitationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Invitation Types'),
        backgroundColor: Colors.purple[100],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const Text(
              'Choose Invitation Type:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            buildOptionCard(
              context,
              title: 'Digital Invitation',
              imageUrl: 'digital_invitation.jpg',
            ),
            const SizedBox(height: 10),
            buildOptionCard(
              context,
              title: 'Traditional Invitation',
              imageUrl: 'traditional_invitation.jpg',
            ),
            const SizedBox(height: 10),
            buildOptionCard(
              context,
              title: 'Customized Invitation',
              imageUrl: 'customized_invitation.jpg',
            ),
          ],
        ),
      ),
    );
  }

  Widget buildOptionCard(BuildContext context,
      {required String title, required String imageUrl}) {
    return InkWell(
      onTap: () {
        // Handle option selection here
      },
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                imageUrl,
                height: 150,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 10),
              Text(
                title,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
