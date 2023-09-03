import 'package:animate_do/animate_do.dart';
import 'package:choppi_prueba_tecnica/characters/bloc/button_search/search_button_bloc.dart';
import 'package:choppi_prueba_tecnica/characters/bloc/search_bloc/search_character_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchButton extends StatelessWidget {
  const SearchButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchButtonBloc, SearchButtonState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            if (state.width == 80.0) {
              BlocProvider.of<SearchButtonBloc>(context)
                  .add(SearchButtonPressed(300.0));
            }
            if (state.width == 300.0) {
              BlocProvider.of<SearchButtonBloc>(context)
                  .add(SearchButtonShrank(80.0));
            }
          },
          child: AnimatedContainer(
            padding: EdgeInsets.symmetric(
                horizontal: state.width == 300.0 ? 20.0 : 0.0),
            duration: const Duration(milliseconds: 1000),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.0),
                color: Colors.white60),
            height: 50.0,
            width: state.width,
            curve: Curves.fastOutSlowIn,
            child: Row(
              children: [
                Expanded(
                    child: Visibility(
                        visible: state.width == 300.0,
                        replacement: FadeIn(
                            child: const Center(
                                child: Text(
                          'Buscar',
                          style: TextStyle(color: Colors.white),
                        ))),
                        child: TextField(
                          enabled: state.width == 300.0,
                          onSubmitted: (value) {
                            BlocProvider.of<SearchCharacterBloc>(context)
                                .add(FormSubmitted(value));
                            Navigator.pushReplacementNamed(context, 'searched-character', arguments: value);
                          },
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                              hintText: 'Morty Smith',
                              border: InputBorder.none,
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    BlocProvider.of<SearchButtonBloc>(context)
                                        .add(SearchButtonShrank(80.0));
                                  },
                                  icon: const Icon(
                                    Icons.close,
                                    color: Colors.white54,
                                  ))),
                        )))
              ],
            ),
          ),
        );
      },
    );
  }
}
