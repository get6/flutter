import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'Person.dart';
import 'sensitiveConstants.dart';

class PeopleList extends StatefulWidget {
  @override
  _PeopleListState createState() => _PeopleListState();
}

class _PeopleListState extends State<PeopleList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('People'),
      ),
      body: scaffoldBody,
      floatingActionButton: FloatingActionButton(onPressed: () {
        Navigator.pushNamed(context, '/peopleUpsert');
      }),
    );
  }

  Widget get scaffoldBody {
    return FutureBuilder(
      future: fetchPeople(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasError) {
          return Text('Oh no! Error! ${snapshot.error}');
        }
        if (!snapshot.hasData) {
          return const Text('No people found');
        }
        final List<Person> people = Person.fromJsonArray(snapshot.data.body);
        final List<Widget> personTiles = people
            .map<Widget>((Person person) => personWidget(person))
            .toList();
        return GridView.extent(
          maxCrossAxisExtent: 300,
          children: personTiles,
        );
      },
    );
  }

  Future<dynamic> fetchPeople() {
    final String url = '$pipedreamRESTUrl/people/?pipedream_response=1';
    return get(url);
  }

  void deletePerson(Person person) {
    final String url = '$pipedreamRESTUrl/people/${person.id}?pipedream_response=1';
    delete(url).then((Response res) {
      setState(() {
        print('Status code: ${res.statusCode}');
      });
    });
  }

  Widget personWidget(Person person) {
    return InkWell(
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed<dynamic>(context, '/peopleUpsert',
              arguments: person);
        },
        child: Container(
          margin: const EdgeInsets.all(5.0),
          child: Stack(
            children: <Widget>[
              if (person.imageUrl != null)
                Image.network(
                  person.imageUrl,
                  height: 300,
                  width: 300,
                  fit: BoxFit.cover,
                )
              else
                Image.asset('lib/assets/images/NoImage.jpg'),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Flexible(
                    child: Text(
                      '${person.name['first']} ${person.name['last']}',
                      style: Theme.of(context)
                          .textTheme
                          .headline6
                          .copyWith(color: Colors.white),
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      deletePerson(person);
                    },
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      person.email,
                      style: Theme.of(context)
                          .textTheme
                          .headline6
                          .copyWith(color: Colors.white),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
