.class public final Lcom/rokid/phone/databinding/LayoutMainPhoneBinding;
.super Ljava/lang/Object;
.source "LayoutMainPhoneBinding.java"

# interfaces
.implements Landroidx/viewbinding/ViewBinding;


# instance fields
.field public final btnAiVision:Landroid/widget/LinearLayout;

.field public final btnConnect:Landroidx/appcompat/widget/AppCompatButton;

.field public final btnGallery:Landroidx/appcompat/widget/AppCompatButton;

.field public final btnP2P:Landroidx/appcompat/widget/AppCompatButton;

.field public final btnSettings:Landroid/widget/ImageButton;

.field public final deviceCard:Landroid/widget/LinearLayout;

.field public final ivConnectStatus:Landroid/widget/ImageView;

.field private final rootView:Landroidx/core/widget/NestedScrollView;

.field public final tvBattery:Landroid/widget/TextView;

.field public final tvConnectionState:Landroid/widget/TextView;

.field public final tvDeviceName:Landroid/widget/TextView;

.field public final tvP2PState:Landroid/widget/TextView;

.field public final tvTitle:Landroid/widget/TextView;


# direct methods
.method private constructor <init>(Landroidx/core/widget/NestedScrollView;Landroid/widget/LinearLayout;Landroidx/appcompat/widget/AppCompatButton;Landroidx/appcompat/widget/AppCompatButton;Landroidx/appcompat/widget/AppCompatButton;Landroid/widget/ImageButton;Landroid/widget/LinearLayout;Landroid/widget/ImageView;Landroid/widget/TextView;Landroid/widget/TextView;Landroid/widget/TextView;Landroid/widget/TextView;Landroid/widget/TextView;)V
    .locals 0
    .param p1, "rootView"    # Landroidx/core/widget/NestedScrollView;
    .param p2, "btnAiVision"    # Landroid/widget/LinearLayout;
    .param p3, "btnConnect"    # Landroidx/appcompat/widget/AppCompatButton;
    .param p4, "btnGallery"    # Landroidx/appcompat/widget/AppCompatButton;
    .param p5, "btnP2P"    # Landroidx/appcompat/widget/AppCompatButton;
    .param p6, "btnSettings"    # Landroid/widget/ImageButton;
    .param p7, "deviceCard"    # Landroid/widget/LinearLayout;
    .param p8, "ivConnectStatus"    # Landroid/widget/ImageView;
    .param p9, "tvBattery"    # Landroid/widget/TextView;
    .param p10, "tvConnectionState"    # Landroid/widget/TextView;
    .param p11, "tvDeviceName"    # Landroid/widget/TextView;
    .param p12, "tvP2PState"    # Landroid/widget/TextView;
    .param p13, "tvTitle"    # Landroid/widget/TextView;

    .line 68
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 69
    iput-object p1, p0, Lcom/rokid/phone/databinding/LayoutMainPhoneBinding;->rootView:Landroidx/core/widget/NestedScrollView;

    .line 70
    iput-object p2, p0, Lcom/rokid/phone/databinding/LayoutMainPhoneBinding;->btnAiVision:Landroid/widget/LinearLayout;

    .line 71
    iput-object p3, p0, Lcom/rokid/phone/databinding/LayoutMainPhoneBinding;->btnConnect:Landroidx/appcompat/widget/AppCompatButton;

    .line 72
    iput-object p4, p0, Lcom/rokid/phone/databinding/LayoutMainPhoneBinding;->btnGallery:Landroidx/appcompat/widget/AppCompatButton;

    .line 73
    iput-object p5, p0, Lcom/rokid/phone/databinding/LayoutMainPhoneBinding;->btnP2P:Landroidx/appcompat/widget/AppCompatButton;

    .line 74
    iput-object p6, p0, Lcom/rokid/phone/databinding/LayoutMainPhoneBinding;->btnSettings:Landroid/widget/ImageButton;

    .line 75
    iput-object p7, p0, Lcom/rokid/phone/databinding/LayoutMainPhoneBinding;->deviceCard:Landroid/widget/LinearLayout;

    .line 76
    iput-object p8, p0, Lcom/rokid/phone/databinding/LayoutMainPhoneBinding;->ivConnectStatus:Landroid/widget/ImageView;

    .line 77
    iput-object p9, p0, Lcom/rokid/phone/databinding/LayoutMainPhoneBinding;->tvBattery:Landroid/widget/TextView;

    .line 78
    iput-object p10, p0, Lcom/rokid/phone/databinding/LayoutMainPhoneBinding;->tvConnectionState:Landroid/widget/TextView;

    .line 79
    iput-object p11, p0, Lcom/rokid/phone/databinding/LayoutMainPhoneBinding;->tvDeviceName:Landroid/widget/TextView;

    .line 80
    iput-object p12, p0, Lcom/rokid/phone/databinding/LayoutMainPhoneBinding;->tvP2PState:Landroid/widget/TextView;

    .line 81
    iput-object p13, p0, Lcom/rokid/phone/databinding/LayoutMainPhoneBinding;->tvTitle:Landroid/widget/TextView;

    .line 82
    return-void
.end method

.method public static bind(Landroid/view/View;)Lcom/rokid/phone/databinding/LayoutMainPhoneBinding;
    .locals 29
    .param p0, "rootView"    # Landroid/view/View;

    .line 111
    move-object/from16 v0, p0

    sget v1, Lcom/rokid/phone/R$id;->btnAiVision:I

    .line 112
    .local v1, "id":I
    invoke-static {v0, v1}, Landroidx/viewbinding/ViewBindings;->findChildViewById(Landroid/view/View;I)Landroid/view/View;

    move-result-object v2

    check-cast v2, Landroid/widget/LinearLayout;

    .line 113
    .local v2, "btnAiVision":Landroid/widget/LinearLayout;
    if-eqz v2, :cond_b

    .line 117
    sget v1, Lcom/rokid/phone/R$id;->btnConnect:I

    .line 118
    invoke-static {v0, v1}, Landroidx/viewbinding/ViewBindings;->findChildViewById(Landroid/view/View;I)Landroid/view/View;

    move-result-object v3

    move-object/from16 v17, v3

    check-cast v17, Landroidx/appcompat/widget/AppCompatButton;

    .line 119
    .local v17, "btnConnect":Landroidx/appcompat/widget/AppCompatButton;
    if-eqz v17, :cond_a

    .line 123
    sget v1, Lcom/rokid/phone/R$id;->btnGallery:I

    .line 124
    invoke-static {v0, v1}, Landroidx/viewbinding/ViewBindings;->findChildViewById(Landroid/view/View;I)Landroid/view/View;

    move-result-object v3

    move-object/from16 v18, v3

    check-cast v18, Landroidx/appcompat/widget/AppCompatButton;

    .line 125
    .local v18, "btnGallery":Landroidx/appcompat/widget/AppCompatButton;
    if-eqz v18, :cond_9

    .line 129
    sget v1, Lcom/rokid/phone/R$id;->btnP2P:I

    .line 130
    invoke-static {v0, v1}, Landroidx/viewbinding/ViewBindings;->findChildViewById(Landroid/view/View;I)Landroid/view/View;

    move-result-object v3

    move-object/from16 v19, v3

    check-cast v19, Landroidx/appcompat/widget/AppCompatButton;

    .line 131
    .local v19, "btnP2P":Landroidx/appcompat/widget/AppCompatButton;
    if-eqz v19, :cond_8

    .line 135
    sget v1, Lcom/rokid/phone/R$id;->btnSettings:I

    .line 136
    invoke-static {v0, v1}, Landroidx/viewbinding/ViewBindings;->findChildViewById(Landroid/view/View;I)Landroid/view/View;

    move-result-object v3

    move-object/from16 v20, v3

    check-cast v20, Landroid/widget/ImageButton;

    .line 137
    .local v20, "btnSettings":Landroid/widget/ImageButton;
    if-eqz v20, :cond_7

    .line 141
    sget v1, Lcom/rokid/phone/R$id;->deviceCard:I

    .line 142
    invoke-static {v0, v1}, Landroidx/viewbinding/ViewBindings;->findChildViewById(Landroid/view/View;I)Landroid/view/View;

    move-result-object v3

    move-object/from16 v21, v3

    check-cast v21, Landroid/widget/LinearLayout;

    .line 143
    .local v21, "deviceCard":Landroid/widget/LinearLayout;
    if-eqz v21, :cond_6

    .line 147
    sget v1, Lcom/rokid/phone/R$id;->ivConnectStatus:I

    .line 148
    invoke-static {v0, v1}, Landroidx/viewbinding/ViewBindings;->findChildViewById(Landroid/view/View;I)Landroid/view/View;

    move-result-object v3

    move-object/from16 v22, v3

    check-cast v22, Landroid/widget/ImageView;

    .line 149
    .local v22, "ivConnectStatus":Landroid/widget/ImageView;
    if-eqz v22, :cond_5

    .line 153
    sget v1, Lcom/rokid/phone/R$id;->tvBattery:I

    .line 154
    invoke-static {v0, v1}, Landroidx/viewbinding/ViewBindings;->findChildViewById(Landroid/view/View;I)Landroid/view/View;

    move-result-object v3

    move-object/from16 v23, v3

    check-cast v23, Landroid/widget/TextView;

    .line 155
    .local v23, "tvBattery":Landroid/widget/TextView;
    if-eqz v23, :cond_4

    .line 159
    sget v1, Lcom/rokid/phone/R$id;->tvConnectionState:I

    .line 160
    invoke-static {v0, v1}, Landroidx/viewbinding/ViewBindings;->findChildViewById(Landroid/view/View;I)Landroid/view/View;

    move-result-object v3

    move-object/from16 v24, v3

    check-cast v24, Landroid/widget/TextView;

    .line 161
    .local v24, "tvConnectionState":Landroid/widget/TextView;
    if-eqz v24, :cond_3

    .line 165
    sget v1, Lcom/rokid/phone/R$id;->tvDeviceName:I

    .line 166
    invoke-static {v0, v1}, Landroidx/viewbinding/ViewBindings;->findChildViewById(Landroid/view/View;I)Landroid/view/View;

    move-result-object v3

    move-object/from16 v25, v3

    check-cast v25, Landroid/widget/TextView;

    .line 167
    .local v25, "tvDeviceName":Landroid/widget/TextView;
    if-eqz v25, :cond_2

    .line 171
    sget v1, Lcom/rokid/phone/R$id;->tvP2PState:I

    .line 172
    invoke-static {v0, v1}, Landroidx/viewbinding/ViewBindings;->findChildViewById(Landroid/view/View;I)Landroid/view/View;

    move-result-object v3

    move-object/from16 v26, v3

    check-cast v26, Landroid/widget/TextView;

    .line 173
    .local v26, "tvP2PState":Landroid/widget/TextView;
    if-eqz v26, :cond_1

    .line 177
    sget v1, Lcom/rokid/phone/R$id;->tvTitle:I

    .line 178
    invoke-static {v0, v1}, Landroidx/viewbinding/ViewBindings;->findChildViewById(Landroid/view/View;I)Landroid/view/View;

    move-result-object v3

    move-object/from16 v27, v3

    check-cast v27, Landroid/widget/TextView;

    .line 179
    .local v27, "tvTitle":Landroid/widget/TextView;
    if-eqz v27, :cond_0

    .line 183
    new-instance v28, Lcom/rokid/phone/databinding/LayoutMainPhoneBinding;

    move-object v4, v0

    check-cast v4, Landroidx/core/widget/NestedScrollView;

    move-object/from16 v3, v28

    move-object v5, v2

    move-object/from16 v6, v17

    move-object/from16 v7, v18

    move-object/from16 v8, v19

    move-object/from16 v9, v20

    move-object/from16 v10, v21

    move-object/from16 v11, v22

    move-object/from16 v12, v23

    move-object/from16 v13, v24

    move-object/from16 v14, v25

    move-object/from16 v15, v26

    move-object/from16 v16, v27

    invoke-direct/range {v3 .. v16}, Lcom/rokid/phone/databinding/LayoutMainPhoneBinding;-><init>(Landroidx/core/widget/NestedScrollView;Landroid/widget/LinearLayout;Landroidx/appcompat/widget/AppCompatButton;Landroidx/appcompat/widget/AppCompatButton;Landroidx/appcompat/widget/AppCompatButton;Landroid/widget/ImageButton;Landroid/widget/LinearLayout;Landroid/widget/ImageView;Landroid/widget/TextView;Landroid/widget/TextView;Landroid/widget/TextView;Landroid/widget/TextView;Landroid/widget/TextView;)V

    return-object v28

    .line 180
    :cond_0
    goto :goto_0

    .line 174
    .end local v27    # "tvTitle":Landroid/widget/TextView;
    :cond_1
    goto :goto_0

    .line 168
    .end local v26    # "tvP2PState":Landroid/widget/TextView;
    :cond_2
    goto :goto_0

    .line 162
    .end local v25    # "tvDeviceName":Landroid/widget/TextView;
    :cond_3
    goto :goto_0

    .line 156
    .end local v24    # "tvConnectionState":Landroid/widget/TextView;
    :cond_4
    goto :goto_0

    .line 150
    .end local v23    # "tvBattery":Landroid/widget/TextView;
    :cond_5
    goto :goto_0

    .line 144
    .end local v22    # "ivConnectStatus":Landroid/widget/ImageView;
    :cond_6
    goto :goto_0

    .line 138
    .end local v21    # "deviceCard":Landroid/widget/LinearLayout;
    :cond_7
    goto :goto_0

    .line 132
    .end local v20    # "btnSettings":Landroid/widget/ImageButton;
    :cond_8
    goto :goto_0

    .line 126
    .end local v19    # "btnP2P":Landroidx/appcompat/widget/AppCompatButton;
    :cond_9
    goto :goto_0

    .line 120
    .end local v18    # "btnGallery":Landroidx/appcompat/widget/AppCompatButton;
    :cond_a
    goto :goto_0

    .line 114
    .end local v17    # "btnConnect":Landroidx/appcompat/widget/AppCompatButton;
    :cond_b
    nop

    .line 187
    .end local v2    # "btnAiVision":Landroid/widget/LinearLayout;
    :goto_0
    invoke-virtual/range {p0 .. p0}, Landroid/view/View;->getResources()Landroid/content/res/Resources;

    move-result-object v2

    invoke-virtual {v2, v1}, Landroid/content/res/Resources;->getResourceName(I)Ljava/lang/String;

    move-result-object v2

    .line 188
    .local v2, "missingId":Ljava/lang/String;
    new-instance v3, Ljava/lang/NullPointerException;

    const-string v4, "Missing required view with ID: "

    invoke-virtual {v4, v2}, Ljava/lang/String;->concat(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    invoke-direct {v3, v4}, Ljava/lang/NullPointerException;-><init>(Ljava/lang/String;)V

    throw v3
.end method

.method public static inflate(Landroid/view/LayoutInflater;)Lcom/rokid/phone/databinding/LayoutMainPhoneBinding;
    .locals 2
    .param p0, "inflater"    # Landroid/view/LayoutInflater;

    .line 92
    const/4 v0, 0x0

    const/4 v1, 0x0

    invoke-static {p0, v0, v1}, Lcom/rokid/phone/databinding/LayoutMainPhoneBinding;->inflate(Landroid/view/LayoutInflater;Landroid/view/ViewGroup;Z)Lcom/rokid/phone/databinding/LayoutMainPhoneBinding;

    move-result-object v0

    return-object v0
.end method

.method public static inflate(Landroid/view/LayoutInflater;Landroid/view/ViewGroup;Z)Lcom/rokid/phone/databinding/LayoutMainPhoneBinding;
    .locals 2
    .param p0, "inflater"    # Landroid/view/LayoutInflater;
    .param p1, "parent"    # Landroid/view/ViewGroup;
    .param p2, "attachToParent"    # Z

    .line 98
    sget v0, Lcom/rokid/phone/R$layout;->layout_main_phone:I

    const/4 v1, 0x0

    invoke-virtual {p0, v0, p1, v1}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;Z)Landroid/view/View;

    move-result-object v0

    .line 99
    .local v0, "root":Landroid/view/View;
    if-eqz p2, :cond_0

    .line 100
    invoke-virtual {p1, v0}, Landroid/view/ViewGroup;->addView(Landroid/view/View;)V

    .line 102
    :cond_0
    invoke-static {v0}, Lcom/rokid/phone/databinding/LayoutMainPhoneBinding;->bind(Landroid/view/View;)Lcom/rokid/phone/databinding/LayoutMainPhoneBinding;

    move-result-object v1

    return-object v1
.end method


# virtual methods
.method public bridge synthetic getRoot()Landroid/view/View;
    .locals 1

    .line 22
    invoke-virtual {p0}, Lcom/rokid/phone/databinding/LayoutMainPhoneBinding;->getRoot()Landroidx/core/widget/NestedScrollView;

    move-result-object v0

    return-object v0
.end method

.method public getRoot()Landroidx/core/widget/NestedScrollView;
    .locals 1

    .line 87
    iget-object v0, p0, Lcom/rokid/phone/databinding/LayoutMainPhoneBinding;->rootView:Landroidx/core/widget/NestedScrollView;

    return-object v0
.end method
