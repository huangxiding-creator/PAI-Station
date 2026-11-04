.class public final Lcom/rokid/phone/databinding/ActivityAiVisionBinding;
.super Ljava/lang/Object;
.source "ActivityAiVisionBinding.java"

# interfaces
.implements Landroidx/viewbinding/ViewBinding;


# instance fields
.field public final btnBack:Landroid/widget/ImageButton;

.field public final btnDownloadReport:Landroidx/appcompat/widget/AppCompatButton;

.field public final btnGenerateReport:Landroidx/appcompat/widget/AppCompatButton;

.field public final recyclerRecords:Landroidx/recyclerview/widget/RecyclerView;

.field private final rootView:Landroid/widget/LinearLayout;

.field public final tvEmpty:Landroid/widget/TextView;


# direct methods
.method private constructor <init>(Landroid/widget/LinearLayout;Landroid/widget/ImageButton;Landroidx/appcompat/widget/AppCompatButton;Landroidx/appcompat/widget/AppCompatButton;Landroidx/recyclerview/widget/RecyclerView;Landroid/widget/TextView;)V
    .locals 0
    .param p1, "rootView"    # Landroid/widget/LinearLayout;
    .param p2, "btnBack"    # Landroid/widget/ImageButton;
    .param p3, "btnDownloadReport"    # Landroidx/appcompat/widget/AppCompatButton;
    .param p4, "btnGenerateReport"    # Landroidx/appcompat/widget/AppCompatButton;
    .param p5, "recyclerRecords"    # Landroidx/recyclerview/widget/RecyclerView;
    .param p6, "tvEmpty"    # Landroid/widget/TextView;

    .line 42
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 43
    iput-object p1, p0, Lcom/rokid/phone/databinding/ActivityAiVisionBinding;->rootView:Landroid/widget/LinearLayout;

    .line 44
    iput-object p2, p0, Lcom/rokid/phone/databinding/ActivityAiVisionBinding;->btnBack:Landroid/widget/ImageButton;

    .line 45
    iput-object p3, p0, Lcom/rokid/phone/databinding/ActivityAiVisionBinding;->btnDownloadReport:Landroidx/appcompat/widget/AppCompatButton;

    .line 46
    iput-object p4, p0, Lcom/rokid/phone/databinding/ActivityAiVisionBinding;->btnGenerateReport:Landroidx/appcompat/widget/AppCompatButton;

    .line 47
    iput-object p5, p0, Lcom/rokid/phone/databinding/ActivityAiVisionBinding;->recyclerRecords:Landroidx/recyclerview/widget/RecyclerView;

    .line 48
    iput-object p6, p0, Lcom/rokid/phone/databinding/ActivityAiVisionBinding;->tvEmpty:Landroid/widget/TextView;

    .line 49
    return-void
.end method

.method public static bind(Landroid/view/View;)Lcom/rokid/phone/databinding/ActivityAiVisionBinding;
    .locals 14
    .param p0, "rootView"    # Landroid/view/View;

    .line 78
    sget v0, Lcom/rokid/phone/R$id;->btnBack:I

    .line 79
    .local v0, "id":I
    invoke-static {p0, v0}, Landroidx/viewbinding/ViewBindings;->findChildViewById(Landroid/view/View;I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/ImageButton;

    .line 80
    .local v1, "btnBack":Landroid/widget/ImageButton;
    if-eqz v1, :cond_4

    .line 84
    sget v0, Lcom/rokid/phone/R$id;->btnDownloadReport:I

    .line 85
    invoke-static {p0, v0}, Landroidx/viewbinding/ViewBindings;->findChildViewById(Landroid/view/View;I)Landroid/view/View;

    move-result-object v2

    move-object v9, v2

    check-cast v9, Landroidx/appcompat/widget/AppCompatButton;

    .line 86
    .local v9, "btnDownloadReport":Landroidx/appcompat/widget/AppCompatButton;
    if-eqz v9, :cond_3

    .line 90
    sget v0, Lcom/rokid/phone/R$id;->btnGenerateReport:I

    .line 91
    invoke-static {p0, v0}, Landroidx/viewbinding/ViewBindings;->findChildViewById(Landroid/view/View;I)Landroid/view/View;

    move-result-object v2

    move-object v10, v2

    check-cast v10, Landroidx/appcompat/widget/AppCompatButton;

    .line 92
    .local v10, "btnGenerateReport":Landroidx/appcompat/widget/AppCompatButton;
    if-eqz v10, :cond_2

    .line 96
    sget v0, Lcom/rokid/phone/R$id;->recyclerRecords:I

    .line 97
    invoke-static {p0, v0}, Landroidx/viewbinding/ViewBindings;->findChildViewById(Landroid/view/View;I)Landroid/view/View;

    move-result-object v2

    move-object v11, v2

    check-cast v11, Landroidx/recyclerview/widget/RecyclerView;

    .line 98
    .local v11, "recyclerRecords":Landroidx/recyclerview/widget/RecyclerView;
    if-eqz v11, :cond_1

    .line 102
    sget v0, Lcom/rokid/phone/R$id;->tvEmpty:I

    .line 103
    invoke-static {p0, v0}, Landroidx/viewbinding/ViewBindings;->findChildViewById(Landroid/view/View;I)Landroid/view/View;

    move-result-object v2

    move-object v12, v2

    check-cast v12, Landroid/widget/TextView;

    .line 104
    .local v12, "tvEmpty":Landroid/widget/TextView;
    if-eqz v12, :cond_0

    .line 108
    new-instance v13, Lcom/rokid/phone/databinding/ActivityAiVisionBinding;

    move-object v3, p0

    check-cast v3, Landroid/widget/LinearLayout;

    move-object v2, v13

    move-object v4, v1

    move-object v5, v9

    move-object v6, v10

    move-object v7, v11

    move-object v8, v12

    invoke-direct/range {v2 .. v8}, Lcom/rokid/phone/databinding/ActivityAiVisionBinding;-><init>(Landroid/widget/LinearLayout;Landroid/widget/ImageButton;Landroidx/appcompat/widget/AppCompatButton;Landroidx/appcompat/widget/AppCompatButton;Landroidx/recyclerview/widget/RecyclerView;Landroid/widget/TextView;)V

    return-object v13

    .line 105
    :cond_0
    goto :goto_0

    .line 99
    .end local v12    # "tvEmpty":Landroid/widget/TextView;
    :cond_1
    goto :goto_0

    .line 93
    .end local v11    # "recyclerRecords":Landroidx/recyclerview/widget/RecyclerView;
    :cond_2
    goto :goto_0

    .line 87
    .end local v10    # "btnGenerateReport":Landroidx/appcompat/widget/AppCompatButton;
    :cond_3
    goto :goto_0

    .line 81
    .end local v9    # "btnDownloadReport":Landroidx/appcompat/widget/AppCompatButton;
    :cond_4
    nop

    .line 111
    .end local v1    # "btnBack":Landroid/widget/ImageButton;
    :goto_0
    invoke-virtual {p0}, Landroid/view/View;->getResources()Landroid/content/res/Resources;

    move-result-object v1

    invoke-virtual {v1, v0}, Landroid/content/res/Resources;->getResourceName(I)Ljava/lang/String;

    move-result-object v1

    .line 112
    .local v1, "missingId":Ljava/lang/String;
    new-instance v2, Ljava/lang/NullPointerException;

    const-string v3, "Missing required view with ID: "

    invoke-virtual {v3, v1}, Ljava/lang/String;->concat(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    invoke-direct {v2, v3}, Ljava/lang/NullPointerException;-><init>(Ljava/lang/String;)V

    throw v2
.end method

.method public static inflate(Landroid/view/LayoutInflater;)Lcom/rokid/phone/databinding/ActivityAiVisionBinding;
    .locals 2
    .param p0, "inflater"    # Landroid/view/LayoutInflater;

    .line 59
    const/4 v0, 0x0

    const/4 v1, 0x0

    invoke-static {p0, v0, v1}, Lcom/rokid/phone/databinding/ActivityAiVisionBinding;->inflate(Landroid/view/LayoutInflater;Landroid/view/ViewGroup;Z)Lcom/rokid/phone/databinding/ActivityAiVisionBinding;

    move-result-object v0

    return-object v0
.end method

.method public static inflate(Landroid/view/LayoutInflater;Landroid/view/ViewGroup;Z)Lcom/rokid/phone/databinding/ActivityAiVisionBinding;
    .locals 2
    .param p0, "inflater"    # Landroid/view/LayoutInflater;
    .param p1, "parent"    # Landroid/view/ViewGroup;
    .param p2, "attachToParent"    # Z

    .line 65
    sget v0, Lcom/rokid/phone/R$layout;->activity_ai_vision:I

    const/4 v1, 0x0

    invoke-virtual {p0, v0, p1, v1}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;Z)Landroid/view/View;

    move-result-object v0

    .line 66
    .local v0, "root":Landroid/view/View;
    if-eqz p2, :cond_0

    .line 67
    invoke-virtual {p1, v0}, Landroid/view/ViewGroup;->addView(Landroid/view/View;)V

    .line 69
    :cond_0
    invoke-static {v0}, Lcom/rokid/phone/databinding/ActivityAiVisionBinding;->bind(Landroid/view/View;)Lcom/rokid/phone/databinding/ActivityAiVisionBinding;

    move-result-object v1

    return-object v1
.end method


# virtual methods
.method public bridge synthetic getRoot()Landroid/view/View;
    .locals 1

    .line 21
    invoke-virtual {p0}, Lcom/rokid/phone/databinding/ActivityAiVisionBinding;->getRoot()Landroid/widget/LinearLayout;

    move-result-object v0

    return-object v0
.end method

.method public getRoot()Landroid/widget/LinearLayout;
    .locals 1

    .line 54
    iget-object v0, p0, Lcom/rokid/phone/databinding/ActivityAiVisionBinding;->rootView:Landroid/widget/LinearLayout;

    return-object v0
.end method
