import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wire_sense/common/Api/api_calling.dart';
import '../../../common/utils/image_res.dart';
import '../../../main.dart';
import '../reverseOutPutScreen/reverse_output.dart';

class ControlCenterPage extends ConsumerStatefulWidget {

  ControlCenterPage({super.key});

  @override
  ConsumerState<ControlCenterPage> createState() => _ControlCenterPageState();
}

class _ControlCenterPageState extends ConsumerState<ControlCenterPage> {
  final TextEditingController utsController = TextEditingController();

  final TextEditingController elongationController = TextEditingController();

  final TextEditingController conductivityController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(



        context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(ImageRes.letterW,height: screenHeight*0.1,),
                  const Text(
                    "ireSense",
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF2074f2),
                      fontFamily: 'Inter',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40,),
              const Text(
                'Aluminium Wire Rod Physical Properties',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Text(
                'Set your desired parameters to begin the process',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[700],
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              _buildInputField(
                screenWidth: screenWidth,
                controller: utsController,
                label: 'UTS (MPa)',
                icon: Icons.handyman,
              ),
              const SizedBox(height: 20),
              _buildInputField(
                screenWidth: screenWidth,
                controller: elongationController,
                label: 'Elongation (%)',
                icon: Icons.straighten,
              ),
              const SizedBox(height: 20),
              _buildInputField(
                screenWidth: screenWidth,
                controller: conductivityController,
                label: 'Conductivity (S/M)',
                icon: Icons.bolt,
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  if(conductivityController.text.isNotEmpty && elongationController.text.isNotEmpty && utsController.text.isNotEmpty)
                    {
                       Navigator.push(context, MaterialPageRoute(builder: (context)=>ReverseOutput(uts: double.parse(utsController.text), conductivity: double.parse(conductivityController.text), elongation: double.parse(elongationController.text),)));

                    }
                  else{
                    showDialog(context: context, builder: (context)=>const Center(child: Text('error occured during call')));
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding:
                  const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                ),
                child: const Text(
                  'Get Initial Parameters',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputField(
      {required TextEditingController controller,
        required String label,
        required IconData icon,
        required double screenWidth}) {
    return SizedBox(
      width: screenWidth * 0.3,
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: Colors.blueAccent),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}

//3 parameters input