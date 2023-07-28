import 'package:flutter/material.dart';

class StepperWidget extends StatefulWidget {
  const StepperWidget({Key? key}) : super(key: key);

  @override
  State<StepperWidget> createState() => _StepperWidgetState();
}

class _StepperWidgetState extends State<StepperWidget> {
  final TextEditingController _personalTextController = TextEditingController();

  int _currentStepper = 0;

  bool _isVerticalStepper = true;

  void _stepTapped(int step) {
    setState(() => _currentStepper = step);
  }

  void _stepContinue() {
    _currentStepper < 2 ? setState(() => _currentStepper += 1) : null;
  }

  void _stepCancel() {
    _currentStepper > 0 ? setState(() => _currentStepper -= 1) : null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stepper Widget'),
      ),
      body: Column(
        children: [
          SwitchListTile(
            title: const Text('Vertical Stepper'),
            value: _isVerticalStepper,
            onChanged: (_) {
              setState(() {
                _isVerticalStepper = !_isVerticalStepper;
              });
            },
          ),
          Expanded(
            child: Stepper(
              type: _isVerticalStepper
                  ? StepperType.vertical
                  : StepperType.horizontal,
              physics: const ScrollPhysics(),
              currentStep: _currentStepper,
              onStepTapped: (step) => _stepTapped(step),
              onStepContinue: _stepContinue,
              onStepCancel: _stepCancel,
              steps: [
                Step(
                  title: Column(
                    children: [
                      const Text('Personal'),
                      Text(
                        _personalTextController.text,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                  content: Column(
                    children: [
                      TextFormField(
                        controller: _personalTextController,
                        decoration: const InputDecoration(
                          labelText: 'Full Name',
                        ),
                      ),
                    ],
                  ),
                  isActive: _currentStepper >= 0,
                  state: _currentStepper >= 0
                      ? StepState.complete
                      : StepState.disabled,
                ),
                Step(
                  title: const Text('Account'),
                  content: Column(
                    children: [
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Password',
                        ),
                      ),
                    ],
                  ),
                  isActive: _currentStepper >= 0,
                  state: _currentStepper >= 1
                      ? StepState.complete
                      : StepState.disabled,
                ),
                Step(
                  title: const Text('Contact'),
                  content: Column(
                    children: [
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Contact Number',
                        ),
                      ),
                    ],
                  ),
                  isActive: _currentStepper >= 0,
                  state: _currentStepper >= 2
                      ? StepState.complete
                      : StepState.disabled,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
