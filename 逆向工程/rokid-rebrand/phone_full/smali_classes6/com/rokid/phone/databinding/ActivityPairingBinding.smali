.class public final Lcom/rokid/phone/databinding/ActivityPairingBinding;
.super Ljava/lang/Object;
.source "ActivityPairingBinding.java"

# interfaces
.implements Landroidx/viewbinding/ViewBinding;


# instance fields
.field public final btnCancel:Landroidx/appcompat/widget/AppCompatButton;

.field public final btnRetry:Landroidx/appcompat/widget/AppCompatButton;

.field public final progress:Landroid/widget/ProgressBar;

.field private final rootView:Landroid/widget/LinearLayout;

.field public final tvBluetoothState:Landroid/widget/TextView;

.field public final tvDeviceName:Landroid/widget/TextView;

.field public final tvP2PState:Landroid/widget/TextView;

.field public final tvPairHint:Landroid/widget/TextView;


# direct methods
.method private constructor <init>(Landroid/widget/LinearLayout;Landroidx/appcompat/widget/AppCompatButton;Landroidx/appcompat/widget/AppCompatButton;Landroid/widget/ProgressBar;Landroid/widget/TextView;Landroid/widget/TextView;Landroid/widget/TextView;Landroid/widget/TextView;)V
    .locals 0
    .param p1, "rootView"    # Landroid/widget/LinearLayout;
    .param p2, "btnCancel"    # Landroidx/appcompat/widget/AppCompatButton;
    .param p3, "btnRetry"    # Landroidx/appcompat/widget/AppCompatButton;
    .param p4, "progress"    # Landroid/widget/ProgressBar;
    .param p5, "tvBluetoothState"    # Landroid/widget/TextView;
    .param p6, "tvDeviceName"    # Landroid/widget/TextView;
    .param p7, "tvP2PState"    # Landroid/widget/TextView;
    .param p8, "tvPairHint"    # Landroid/widget/TextView;

    .line 48
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 49
    iput-object p1, p0, Lcom/rokid/phone/databinding/ActivityPairingBinding;->rootView:Landroid/widget/LinearLayout;

    .line 50
    iput-object p2, p0, Lcom/rokid/phone/databinding/ActivityPairingBinding;->btnCancel:Landroidx/appcompat/widget/AppCompatButton;

    .line 51
    iput-object p3, p0, Lcom/rokid/phone/databinding/ActivityPairingBinding;->btnRetry:Landroidx/appcompat/widget/AppCompatButton;

    .line 52
    iput-object p4, p0, Lcom/rokid/phone/databinding/ActivityPairingBinding;->progress:Landroid/widget/ProgressBar;

    .line 53
    iput-object p5, p0, Lcom/rokid/phone/databinding/ActivityPairingBinding;->tvBluetoothState:Landroid/widget/TextView;

    .line 54
    iput-object p6, p0, Lcom/rokid/phone/databinding/ActivityPairingBinding;->tvDeviceName:Landroid/widget/TextView;

    .line 55
    iput-object p7, p0, Lcom/rokid/phone/databinding/ActivityPairingBinding;->tvP2PState:Landroid/widget/TextView;

    .line 56
    iput-object p8, p0, Lcom/rokid/phone/databinding/ActivityPairingBinding;->tvPairHint:Landroid/widget/TextView;

    .line 57
    return-void
.end method

.method public static bind(Landroid/view/View;)Lcom/rokid/phone/databinding/ActivityPairingBinding;
    .locals 19
    .param p0, "rootView"    # Landroid/view/View;

    .line 86
    move-object/from16 v0, p0

    sget v1, Lcom/rokid/phone/R$id;->btnCancel:I

    .line 87
    .local v1, "id":I
    invoke-static {v0, v1}, Landroidx/viewbinding/ViewBindings;->findChildViewById(Landroid/view/View;I)Landroid/view/View;

    move-result-object v2

    check-cast v2, Landroidx/appcompat/widget/AppCompatButton;

    .line 88
    .local v2, "btnCancel":Landroidx/appcompat/widget/AppCompatButton;
    if-eqz v2, :cond_6

    .line 92
    sget v1, Lcom/rokid/phone/R$id;->btnRetry:I

    .line 93
    invoke-static {v0, v1}, Landroidx/viewbinding/ViewBindings;->findChildViewById(Landroid/view/View;I)Landroid/view/View;

    move-result-object v3

    move-object v12, v3

    check-cast v12, Landroidx/appcompat/widget/AppCompatButton;

    .line 94
    .local v12, "btnRetry":Landroidx/appcompat/widget/AppCompatButton;
    if-eqz v12, :cond_5

    .line 98
    sget v1, Lcom/rokid/phone/R$id;->progress:I

    .line 99
    invoke-static {v0, v1}, Landroidx/viewbinding/ViewBindings;->findChildViewById(Landroid/view/View;I)Landroid/view/View;

    move-result-object v3

    move-object v13, v3

    check-cast v13, Landroid/widget/ProgressBar;

    .line 100
    .local v13, "progress":Landroid/widget/ProgressBar;
    if-eqz v13, :cond_4

    .line 104
    sget v1, Lcom/rokid/phone/R$id;->tvBluetoothState:I

    .line 105
    invoke-static {v0, v1}, Landroidx/viewbinding/ViewBindings;->findChildViewById(Landroid/view/View;I)Landroid/view/View;

    move-result-object v3

    move-object v14, v3

    check-cast v14, Landroid/widget/TextView;

    .line 106
    .local v14, "tvBluetoothState":Landroid/widget/TextView;
    if-eqz v14, :cond_3

    .line 110
    sget v1, Lcom/rokid/phone/R$id;->tvDeviceName:I

    .line 111
    invoke-static {v0, v1}, Landroidx/viewbinding/ViewBindings;->findChildViewById(Landroid/view/View;I)Landroid/view/View;

    move-result-object v3

    move-object v15, v3

    check-cast v15, Landroid/widget/TextView;

    .line 112
    .local v15, "tvDeviceName":Landroid/widget/TextView;
    if-eqz v15, :cond_2

    .line 116
    sget v1, Lcom/rokid/phone/R$id;->tvP2PState:I

    .line 117
    invoke-static {v0, v1}, Landroidx/viewbinding/ViewBindings;->findChildViewById(Landroid/view/View;I)Landroid/view/View;

    move-result-object v3

    move-object/from16 v16, v3

    check-cast v16, Landroid/widget/TextView;

    .line 118
    .local v16, "tvP2PState":Landroid/widget/TextView;
    if-eqz v16, :cond_1

    .line 122
    sget v1, Lcom/rokid/phone/R$id;->tvPairHint:I

    .line 123
    invoke-static {v0, v1}, Landroidx/viewbinding/ViewBindings;->findChildViewById(Landroid/view/View;I)Landroid/view/View;

    move-result-object v3

    move-object/from16 v17, v3

    check-cast v17, Landroid/widget/TextView;

    .line 124
    .local v17, "tvPairHint":Landroid/widget/TextView;
    if-eqz v17, :cond_0

    .line 128
    new-instance v18, Lcom/rokid/phone/databinding/ActivityPairingBinding;

    move-object v4, v0

    check-cast v4, Landroid/widget/LinearLayout;

    move-object/from16 v3, v18

    move-object v5, v2

    move-object v6, v12

    move-object v7, v13

    move-object v8, v14

    move-object v9, v15

    move-object/from16 v10, v16

    move-object/from16 v11, v17

    invoke-direct/range {v3 .. v11}, Lcom/rokid/phone/databinding/ActivityPairingBinding;-><init>(Landroid/widget/LinearLayout;Landroidx/appcompat/widget/AppCompatButton;Landroidx/appcompat/widget/AppCompatButton;Landroid/widget/ProgressBar;Landroid/widget/TextView;Landroid/widget/TextView;Landroid/widget/TextView;Landroid/widget/TextView;)V

    return-object v18

    .line 125
    :cond_0
    goto :goto_0

    .line 119
    .end local v17    # "tvPairHint":Landroid/widget/TextView;
    :cond_1
    goto :goto_0

    .line 113
    .end local v16    # "tvP2PState":Landroid/widget/TextView;
    :cond_2
    goto :goto_0

    .line 107
    .end local v15    # "tvDeviceName":Landroid/widget/TextView;
    :cond_3
    goto :goto_0

    .line 101
    .end local v14    # "tvBluetoothState":Landroid/widget/TextView;
    :cond_4
    goto :goto_0

    .line 95
    .end local v13    # "progress":Landroid/widget/ProgressBar;
    :cond_5
    goto :goto_0

    .line 89
    .end local v12    # "btnRetry":Landroidx/appcompat/widget/AppCompatButton;
    :cond_6
    nop

    .line 131
    .end local v2    # "btnCancel":Landroidx/appcompat/widget/AppCompatButton;
    :goto_0
    invoke-virtual/range {p0 .. p0}, Landroid/view/View;->getResources()Landroid/content/res/Resources;

    move-result-object v2

    invoke-virtual {v2, v1}, Landroid/content/res/Resources;->getResourceName(I)Ljava/lang/String;

    move-result-object v2

    .line 132
    .local v2, "missingId":Ljava/lang/String;
    new-instance v3, Ljava/lang/NullPointerException;

    const-string v4, "Missing required view with ID: "

    invoke-virtual {v4, v2}, Ljava/lang/String;->concat(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    invoke-direct {v3, v4}, Ljava/lang/NullPointerException;-><init>(Ljava/lang/String;)V

    throw v3
.end method

.method public static inflate(Landroid/view/LayoutInflater;)Lcom/rokid/phone/databinding/ActivityPairingBinding;
    .locals 2
    .param p0, "inflater"    # Landroid/view/LayoutInflater;

    .line 67
    const/4 v0, 0x0

    const/4 v1, 0x0

    invoke-static {p0, v0, v1}, Lcom/rokid/phone/databinding/ActivityPairingBinding;->inflate(Landroid/view/LayoutInflater;Landroid/view/ViewGroup;Z)Lcom/rokid/phone/databinding/ActivityPairingBinding;

    move-result-object v0

    return-object v0
.end method

.method public static inflate(Landroid/view/LayoutInflater;Landroid/view/ViewGroup;Z)Lcom/rokid/phone/databinding/ActivityPairingBinding;
    .locals 2
    .param p0, "inflater"    # Landroid/view/LayoutInflater;
    .param p1, "parent"    # Landroid/view/ViewGroup;
    .param p2, "attachToParent"    # Z

    .line 73
    sget v0, Lcom/rokid/phone/R$layout;->activity_pairing:I

    const/4 v1, 0x0

    invoke-virtual {p0, v0, p1, v1}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;Z)Landroid/view/View;

    move-result-object v0

    .line 74
    .local v0, "root":Landroid/view/View;
    if-eqz p2, :cond_0

    .line 75
    invoke-virtual {p1, v0}, Landroid/view/ViewGroup;->addView(Landroid/view/View;)V

    .line 77
    :cond_0
    invoke-static {v0}, Lcom/rokid/phone/databinding/ActivityPairingBinding;->bind(Landroid/view/View;)Lcom/rokid/phone/databinding/ActivityPairingBinding;

    move-result-object v1

    return-object v1
.end method


# virtual methods
.method public bridge synthetic getRoot()Landroid/view/View;
    .locals 1

    .line 20
    invoke-virtual {p0}, Lcom/rokid/phone/databinding/ActivityPairingBinding;->getRoot()Landroid/widget/LinearLayout;

    move-result-object v0

    return-object v0
.end method

.method public getRoot()Landroid/widget/LinearLayout;
    .locals 1

    .line 62
    iget-object v0, p0, Lcom/rokid/phone/databinding/ActivityPairingBinding;->rootView:Landroid/widget/LinearLayout;

    return-object v0
.end method
