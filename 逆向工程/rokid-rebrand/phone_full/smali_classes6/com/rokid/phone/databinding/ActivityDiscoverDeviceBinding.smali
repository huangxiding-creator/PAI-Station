.class public final Lcom/rokid/phone/databinding/ActivityDiscoverDeviceBinding;
.super Ljava/lang/Object;
.source "ActivityDiscoverDeviceBinding.java"

# interfaces
.implements Landroidx/viewbinding/ViewBinding;


# instance fields
.field public final ivBack:Landroid/widget/ImageView;

.field public final ivLoadReflesh:Landroid/widget/ImageView;

.field public final ivLoadSmall:Landroid/widget/ImageView;

.field private final rootView:Landroidx/constraintlayout/widget/ConstraintLayout;

.field public final rvDiscoveredDevices:Landroidx/recyclerview/widget/RecyclerView;

.field public final tvListTip1:Landroid/widget/TextView;

.field public final tvListTip2:Landroid/widget/TextView;

.field public final tvSkip:Landroid/widget/TextView;

.field public final tvSubtitleDiscoverDevice:Landroid/widget/TextView;

.field public final tvTitleDiscoverDevice:Landroid/widget/TextView;


# direct methods
.method private constructor <init>(Landroidx/constraintlayout/widget/ConstraintLayout;Landroid/widget/ImageView;Landroid/widget/ImageView;Landroid/widget/ImageView;Landroidx/recyclerview/widget/RecyclerView;Landroid/widget/TextView;Landroid/widget/TextView;Landroid/widget/TextView;Landroid/widget/TextView;Landroid/widget/TextView;)V
    .locals 0
    .param p1, "rootView"    # Landroidx/constraintlayout/widget/ConstraintLayout;
    .param p2, "ivBack"    # Landroid/widget/ImageView;
    .param p3, "ivLoadReflesh"    # Landroid/widget/ImageView;
    .param p4, "ivLoadSmall"    # Landroid/widget/ImageView;
    .param p5, "rvDiscoveredDevices"    # Landroidx/recyclerview/widget/RecyclerView;
    .param p6, "tvListTip1"    # Landroid/widget/TextView;
    .param p7, "tvListTip2"    # Landroid/widget/TextView;
    .param p8, "tvSkip"    # Landroid/widget/TextView;
    .param p9, "tvSubtitleDiscoverDevice"    # Landroid/widget/TextView;
    .param p10, "tvTitleDiscoverDevice"    # Landroid/widget/TextView;

    .line 55
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 56
    iput-object p1, p0, Lcom/rokid/phone/databinding/ActivityDiscoverDeviceBinding;->rootView:Landroidx/constraintlayout/widget/ConstraintLayout;

    .line 57
    iput-object p2, p0, Lcom/rokid/phone/databinding/ActivityDiscoverDeviceBinding;->ivBack:Landroid/widget/ImageView;

    .line 58
    iput-object p3, p0, Lcom/rokid/phone/databinding/ActivityDiscoverDeviceBinding;->ivLoadReflesh:Landroid/widget/ImageView;

    .line 59
    iput-object p4, p0, Lcom/rokid/phone/databinding/ActivityDiscoverDeviceBinding;->ivLoadSmall:Landroid/widget/ImageView;

    .line 60
    iput-object p5, p0, Lcom/rokid/phone/databinding/ActivityDiscoverDeviceBinding;->rvDiscoveredDevices:Landroidx/recyclerview/widget/RecyclerView;

    .line 61
    iput-object p6, p0, Lcom/rokid/phone/databinding/ActivityDiscoverDeviceBinding;->tvListTip1:Landroid/widget/TextView;

    .line 62
    iput-object p7, p0, Lcom/rokid/phone/databinding/ActivityDiscoverDeviceBinding;->tvListTip2:Landroid/widget/TextView;

    .line 63
    iput-object p8, p0, Lcom/rokid/phone/databinding/ActivityDiscoverDeviceBinding;->tvSkip:Landroid/widget/TextView;

    .line 64
    iput-object p9, p0, Lcom/rokid/phone/databinding/ActivityDiscoverDeviceBinding;->tvSubtitleDiscoverDevice:Landroid/widget/TextView;

    .line 65
    iput-object p10, p0, Lcom/rokid/phone/databinding/ActivityDiscoverDeviceBinding;->tvTitleDiscoverDevice:Landroid/widget/TextView;

    .line 66
    return-void
.end method

.method public static bind(Landroid/view/View;)Lcom/rokid/phone/databinding/ActivityDiscoverDeviceBinding;
    .locals 23
    .param p0, "rootView"    # Landroid/view/View;

    .line 95
    move-object/from16 v0, p0

    sget v1, Lcom/rokid/phone/R$id;->iv_back:I

    .line 96
    .local v1, "id":I
    invoke-static {v0, v1}, Landroidx/viewbinding/ViewBindings;->findChildViewById(Landroid/view/View;I)Landroid/view/View;

    move-result-object v2

    check-cast v2, Landroid/widget/ImageView;

    .line 97
    .local v2, "ivBack":Landroid/widget/ImageView;
    if-eqz v2, :cond_8

    .line 101
    sget v1, Lcom/rokid/phone/R$id;->iv_load_reflesh:I

    .line 102
    invoke-static {v0, v1}, Landroidx/viewbinding/ViewBindings;->findChildViewById(Landroid/view/View;I)Landroid/view/View;

    move-result-object v3

    move-object v14, v3

    check-cast v14, Landroid/widget/ImageView;

    .line 103
    .local v14, "ivLoadReflesh":Landroid/widget/ImageView;
    if-eqz v14, :cond_7

    .line 107
    sget v1, Lcom/rokid/phone/R$id;->iv_load_small:I

    .line 108
    invoke-static {v0, v1}, Landroidx/viewbinding/ViewBindings;->findChildViewById(Landroid/view/View;I)Landroid/view/View;

    move-result-object v3

    move-object v15, v3

    check-cast v15, Landroid/widget/ImageView;

    .line 109
    .local v15, "ivLoadSmall":Landroid/widget/ImageView;
    if-eqz v15, :cond_6

    .line 113
    sget v1, Lcom/rokid/phone/R$id;->rv_discovered_devices:I

    .line 114
    invoke-static {v0, v1}, Landroidx/viewbinding/ViewBindings;->findChildViewById(Landroid/view/View;I)Landroid/view/View;

    move-result-object v3

    move-object/from16 v16, v3

    check-cast v16, Landroidx/recyclerview/widget/RecyclerView;

    .line 115
    .local v16, "rvDiscoveredDevices":Landroidx/recyclerview/widget/RecyclerView;
    if-eqz v16, :cond_5

    .line 119
    sget v1, Lcom/rokid/phone/R$id;->tv_list_tip_1:I

    .line 120
    invoke-static {v0, v1}, Landroidx/viewbinding/ViewBindings;->findChildViewById(Landroid/view/View;I)Landroid/view/View;

    move-result-object v3

    move-object/from16 v17, v3

    check-cast v17, Landroid/widget/TextView;

    .line 121
    .local v17, "tvListTip1":Landroid/widget/TextView;
    if-eqz v17, :cond_4

    .line 125
    sget v1, Lcom/rokid/phone/R$id;->tv_list_tip_2:I

    .line 126
    invoke-static {v0, v1}, Landroidx/viewbinding/ViewBindings;->findChildViewById(Landroid/view/View;I)Landroid/view/View;

    move-result-object v3

    move-object/from16 v18, v3

    check-cast v18, Landroid/widget/TextView;

    .line 127
    .local v18, "tvListTip2":Landroid/widget/TextView;
    if-eqz v18, :cond_3

    .line 131
    sget v1, Lcom/rokid/phone/R$id;->tv_skip:I

    .line 132
    invoke-static {v0, v1}, Landroidx/viewbinding/ViewBindings;->findChildViewById(Landroid/view/View;I)Landroid/view/View;

    move-result-object v3

    move-object/from16 v19, v3

    check-cast v19, Landroid/widget/TextView;

    .line 133
    .local v19, "tvSkip":Landroid/widget/TextView;
    if-eqz v19, :cond_2

    .line 137
    sget v1, Lcom/rokid/phone/R$id;->tv_subtitle_discover_device:I

    .line 138
    invoke-static {v0, v1}, Landroidx/viewbinding/ViewBindings;->findChildViewById(Landroid/view/View;I)Landroid/view/View;

    move-result-object v3

    move-object/from16 v20, v3

    check-cast v20, Landroid/widget/TextView;

    .line 139
    .local v20, "tvSubtitleDiscoverDevice":Landroid/widget/TextView;
    if-eqz v20, :cond_1

    .line 143
    sget v1, Lcom/rokid/phone/R$id;->tv_title_discover_device:I

    .line 144
    invoke-static {v0, v1}, Landroidx/viewbinding/ViewBindings;->findChildViewById(Landroid/view/View;I)Landroid/view/View;

    move-result-object v3

    move-object/from16 v21, v3

    check-cast v21, Landroid/widget/TextView;

    .line 145
    .local v21, "tvTitleDiscoverDevice":Landroid/widget/TextView;
    if-eqz v21, :cond_0

    .line 149
    new-instance v22, Lcom/rokid/phone/databinding/ActivityDiscoverDeviceBinding;

    move-object v4, v0

    check-cast v4, Landroidx/constraintlayout/widget/ConstraintLayout;

    move-object/from16 v3, v22

    move-object v5, v2

    move-object v6, v14

    move-object v7, v15

    move-object/from16 v8, v16

    move-object/from16 v9, v17

    move-object/from16 v10, v18

    move-object/from16 v11, v19

    move-object/from16 v12, v20

    move-object/from16 v13, v21

    invoke-direct/range {v3 .. v13}, Lcom/rokid/phone/databinding/ActivityDiscoverDeviceBinding;-><init>(Landroidx/constraintlayout/widget/ConstraintLayout;Landroid/widget/ImageView;Landroid/widget/ImageView;Landroid/widget/ImageView;Landroidx/recyclerview/widget/RecyclerView;Landroid/widget/TextView;Landroid/widget/TextView;Landroid/widget/TextView;Landroid/widget/TextView;Landroid/widget/TextView;)V

    return-object v22

    .line 146
    :cond_0
    goto :goto_0

    .line 140
    .end local v21    # "tvTitleDiscoverDevice":Landroid/widget/TextView;
    :cond_1
    goto :goto_0

    .line 134
    .end local v20    # "tvSubtitleDiscoverDevice":Landroid/widget/TextView;
    :cond_2
    goto :goto_0

    .line 128
    .end local v19    # "tvSkip":Landroid/widget/TextView;
    :cond_3
    goto :goto_0

    .line 122
    .end local v18    # "tvListTip2":Landroid/widget/TextView;
    :cond_4
    goto :goto_0

    .line 116
    .end local v17    # "tvListTip1":Landroid/widget/TextView;
    :cond_5
    goto :goto_0

    .line 110
    .end local v16    # "rvDiscoveredDevices":Landroidx/recyclerview/widget/RecyclerView;
    :cond_6
    goto :goto_0

    .line 104
    .end local v15    # "ivLoadSmall":Landroid/widget/ImageView;
    :cond_7
    goto :goto_0

    .line 98
    .end local v14    # "ivLoadReflesh":Landroid/widget/ImageView;
    :cond_8
    nop

    .line 153
    .end local v2    # "ivBack":Landroid/widget/ImageView;
    :goto_0
    invoke-virtual/range {p0 .. p0}, Landroid/view/View;->getResources()Landroid/content/res/Resources;

    move-result-object v2

    invoke-virtual {v2, v1}, Landroid/content/res/Resources;->getResourceName(I)Ljava/lang/String;

    move-result-object v2

    .line 154
    .local v2, "missingId":Ljava/lang/String;
    new-instance v3, Ljava/lang/NullPointerException;

    const-string v4, "Missing required view with ID: "

    invoke-virtual {v4, v2}, Ljava/lang/String;->concat(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    invoke-direct {v3, v4}, Ljava/lang/NullPointerException;-><init>(Ljava/lang/String;)V

    throw v3
.end method

.method public static inflate(Landroid/view/LayoutInflater;)Lcom/rokid/phone/databinding/ActivityDiscoverDeviceBinding;
    .locals 2
    .param p0, "inflater"    # Landroid/view/LayoutInflater;

    .line 76
    const/4 v0, 0x0

    const/4 v1, 0x0

    invoke-static {p0, v0, v1}, Lcom/rokid/phone/databinding/ActivityDiscoverDeviceBinding;->inflate(Landroid/view/LayoutInflater;Landroid/view/ViewGroup;Z)Lcom/rokid/phone/databinding/ActivityDiscoverDeviceBinding;

    move-result-object v0

    return-object v0
.end method

.method public static inflate(Landroid/view/LayoutInflater;Landroid/view/ViewGroup;Z)Lcom/rokid/phone/databinding/ActivityDiscoverDeviceBinding;
    .locals 2
    .param p0, "inflater"    # Landroid/view/LayoutInflater;
    .param p1, "parent"    # Landroid/view/ViewGroup;
    .param p2, "attachToParent"    # Z

    .line 82
    sget v0, Lcom/rokid/phone/R$layout;->activity_discover_device:I

    const/4 v1, 0x0

    invoke-virtual {p0, v0, p1, v1}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;Z)Landroid/view/View;

    move-result-object v0

    .line 83
    .local v0, "root":Landroid/view/View;
    if-eqz p2, :cond_0

    .line 84
    invoke-virtual {p1, v0}, Landroid/view/ViewGroup;->addView(Landroid/view/View;)V

    .line 86
    :cond_0
    invoke-static {v0}, Lcom/rokid/phone/databinding/ActivityDiscoverDeviceBinding;->bind(Landroid/view/View;)Lcom/rokid/phone/databinding/ActivityDiscoverDeviceBinding;

    move-result-object v1

    return-object v1
.end method


# virtual methods
.method public bridge synthetic getRoot()Landroid/view/View;
    .locals 1

    .line 20
    invoke-virtual {p0}, Lcom/rokid/phone/databinding/ActivityDiscoverDeviceBinding;->getRoot()Landroidx/constraintlayout/widget/ConstraintLayout;

    move-result-object v0

    return-object v0
.end method

.method public getRoot()Landroidx/constraintlayout/widget/ConstraintLayout;
    .locals 1

    .line 71
    iget-object v0, p0, Lcom/rokid/phone/databinding/ActivityDiscoverDeviceBinding;->rootView:Landroidx/constraintlayout/widget/ConstraintLayout;

    return-object v0
.end method
