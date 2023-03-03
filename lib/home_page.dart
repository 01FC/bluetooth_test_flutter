import 'package:blue_test/bloc/blue_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Bluetooth test'),
          actions: [
            IconButton(
              tooltip: "Refresh devices list",
              onPressed: () {
                BlocProvider.of<BlueBloc>(context).add(StartScanningEvent());
              },
              icon: Icon(Icons.refresh),
            ),
          ],
        ),
        body: BlocBuilder<BlueBloc, BlueState>(
          builder: (context, state) {
            if (state is BlueLookingForDevicesState)
              return Center(child: CircularProgressIndicator());
            else if (state is BlueFoundDevicesState)
              return Column(
                children: [
                  Text("Dispositivos conectados:"),
                  Expanded(child: _connectedDevices(context)),
                  Text("Caracteristicas:"),
                  Expanded(child: _caracteristics(context)),
                ],
              );
            else
              return Text("Procesando ...");
          },
        ));
  }

  ListView _connectedDevices(BuildContext context) {
    return ListView.builder(
      itemCount: BlocProvider.of<BlueBloc>(context).getConnDevicesList.length,
      itemBuilder: (BuildContext context, int index) {
        return Text(
            "Bluetooth connected ${BlocProvider.of<BlueBloc>(context).getConnDevicesList[index].name}");
      },
    );
  }

  ListView _caracteristics(BuildContext context) {
    return ListView.builder(
      itemCount:
          BlocProvider.of<BlueBloc>(context).getCharacteristicsList.length,
      itemBuilder: (BuildContext context, int index) {
        return Text(
            "Caracteristic [$index]: ${BlocProvider.of<BlueBloc>(context).getCharacteristicsList[index]}");
      },
    );
  }

  ListView _availableDevices(BuildContext context) {
    return ListView.separated(
      itemCount: BlocProvider.of<BlueBloc>(context).getDevicesList.length,
      separatorBuilder: (BuildContext context, int index) {
        return Divider();
      },
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: Text("Bluetooth device $index"),
          subtitle: Text(
              "${BlocProvider.of<BlueBloc>(context).getDevicesList[index].device.id}"),
          onLongPress: () {
            // TODO: conectar usando el bloc
          },
        );
      },
    );
  }
}
