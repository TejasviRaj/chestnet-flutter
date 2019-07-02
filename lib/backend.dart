import 'package:flutter/material.dart';


String getword(int index)
{
  var words = ["anomaly","equivocal","lucid","precipitate","assuage","erudite","opaque","prodigal","enigma","fervid"];
  String ans= index==1? "Hello" : "Bye";
      return words[index-1];
}

String getmeaning(int index)
{
  var meaning=[" something that is unusual or unexpected ","not easily understood or explained" ,"very clear and easy to understand", "to cause (something) to happen quickly or suddenly"," to make (an unpleasant feeling) less intense"," having or showing great knowledge" , " not able to be seen through"," not easily understood", "wastefully extravagant", "a person or thing that is mysterious, puzzling, or difficult to understand", "intensely enthusiastic or passionate" ];
  return meaning[index-1];
}

String getexample (int index)
{
  var example =[
  "The student’s poor performance on the latest test was an anomaly since she had previously earned excellent grades.",

"Politicians have been known to provide equivocal answers to reporters’ questions.",

"The lecture was lucid and straightforward, allowing the students to fully grasp the concepts presented.",

"Unforeseen costs can precipitate a budget crisis.",

"A massage can assuage the soreness in your muscles.",

"High school students often struggle with novels that are more erudite than they are entertaining.",

"Medical jargon includes many opaque terms like macrosomic, which describes a newborn who weighs more than 4,000 grams.",

"The prodigal prince bought lavish gifts and planned expensive events.",

"Scientists continue to research cancer to solve the enigma of its primary cause, which will hopefully lead to a cure.",

"The child showed a fervid fascination for superheroes, pouring over comic books for hours.",
];
  return example[index-1];
}


void logout()
{
  print ("logout");
}

int login(BuildContext context, String email, String password)
{
  print(email);
  print(password);

  if (email=='tejpant@gmail.com' && password =='harkabahadur')
  return 0;

  else
    return 1;
}
