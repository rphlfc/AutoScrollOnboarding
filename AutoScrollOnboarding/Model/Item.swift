//
//  Item.swift
//  AutoScrollOnboarding
//
//  Created by Raphael Cerqueira on 23/06/21.
//

import SwiftUI

struct Item: Identifiable {
    let id = UUID().uuidString
    var image: String
    var title: String
    var subtitle: String
}

let data = [
    Item(image: "sun.max", title: "Acompanhe todo seu consumo de internet através do aplicativo",
         subtitle: "Veja o quanto já consumiu de internet do seu plano e o quanto ainda tem disponível para navegar."),
    Item(image: "dollarsign.circle", title: "Visualize as informações das suas últimas faturas", subtitle: "Você poderá acompanhar as últimas faturas geradas após a migração para Claro diretamente no aplicativo."),
    Item(image: "gift", title: "Acompanhe seus pontos e benefícios no programa Claro clube",
         subtitle: "Confira seus pontos no Claro clube e troque por produtos, serviços e experiências incríveis."),
    Item(image: "person", title: "Informações do seu perfil sempre atualizadas no aplicativo", subtitle: "Mantenha seus dados pessoais atualizados, gerencie seu plano e as permissões de acesso.")
    
]

let welcomeItem = Item(image: "sun.max", title: "Pronto!\nAproveite estas e outras novidades no aplicativo.", subtitle: "Além destas principais funcionalidades no aplicativo você também pode explorar e conhecer outras opções.")
