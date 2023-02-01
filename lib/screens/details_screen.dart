import 'package:flutter/material.dart';


class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
   
   //TODO Cambiar luego por una instancia de movie

   final String movie = ModalRoute.of(context)?.settings.arguments.toString() ?? 'no-movie';
    return  Scaffold(
      body:  CustomScrollView(
        slivers: [
          const _CustomAppBar(),
          SliverList(
            delegate: SliverChildListDelegate([
              Text('Holis')
        ])
          )
        ],
      ),
    );
  }
}

class _CustomAppBar extends StatelessWidget {
  const _CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return  SliverAppBar(
      backgroundColor: Colors.indigo,
      expandedHeight: 200,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: EdgeInsets.all(0),
        title: Container(
          color: Colors.black12,
          alignment: Alignment.bottomCenter,
          width: double.infinity,
          child: const Text('movie.title',
          style: TextStyle(fontSize: 16)),
        ),
        background: const FadeInImage(placeholder: AssetImage('assets/loading.gif'),
         image: NetworkImage('https://via.placeholder.com/500x300'),
         fit: BoxFit.cover,),
      ),
    );
  }
}

class _PosterAndTitle extends StatelessWidget {
  const _PosterAndTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}