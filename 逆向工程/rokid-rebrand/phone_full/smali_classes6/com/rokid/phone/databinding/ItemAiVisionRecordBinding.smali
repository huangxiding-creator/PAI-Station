.class public final Lcom/rokid/phone/databinding/ItemAiVisionRecordBinding;
.super Ljava/lang/Object;
.source "ItemAiVisionRecordBinding.java"

# interfaces
.implements Landroidx/viewbinding/ViewBinding;


# instance fields
.field public final ivImage:Landroid/widget/ImageView;

.field private final rootView:Landroidx/constraintlayout/widget/ConstraintLayout;

.field public final tvAnswer:Landroid/widget/TextView;

.field public final tvQuestion:Landroid/widget/TextView;

.field public final tvTime:Landroid/widget/TextView;


# direct methods
.method private constructor <init>(Landroidx/constraintlayout/widget/ConstraintLayout;Landroid/widget/ImageView;Landroid/widget/TextView;Landroid/widget/TextView;Landroid/widget/TextView;)V
    .locals 0
    .param p1, "rootView"    # Landroidx/constraintlayout/widget/ConstraintLayout;
    .param p2, "ivImage"    # Landroid/widget/ImageView;
    .param p3, "tvAnswer"    # Landroid/widget/TextView;
    .param p4, "tvQuestion"    # Landroid/widget/TextView;
    .param p5, "tvTime"    # Landroid/widget/TextView;

    .line 36
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 37
    iput-object p1, p0, Lcom/rokid/phone/databinding/ItemAiVisionRecordBinding;->rootView:Landroidx/constraintlayout/widget/ConstraintLayout;

    .line 38
    iput-object p2, p0, Lcom/rokid/phone/databinding/ItemAiVisionRecordBinding;->ivImage:Landroid/widget/ImageView;

    .line 39
    iput-object p3, p0, Lcom/rokid/phone/databinding/ItemAiVisionRecordBinding;->tvAnswer:Landroid/widget/TextView;

    .line 40
    iput-object p4, p0, Lcom/rokid/phone/databinding/ItemAiVisionRecordBinding;->tvQuestion:Landroid/widget/TextView;

    .line 41
    iput-object p5, p0, Lcom/rokid/phone/databinding/ItemAiVisionRecordBinding;->tvTime:Landroid/widget/TextView;

    .line 42
    return-void
.end method

.method public static bind(Landroid/view/View;)Lcom/rokid/phone/databinding/ItemAiVisionRecordBinding;
    .locals 12
    .param p0, "rootView"    # Landroid/view/View;

    .line 71
    sget v0, Lcom/rokid/phone/R$id;->ivImage:I

    .line 72
    .local v0, "id":I
    invoke-static {p0, v0}, Landroidx/viewbinding/ViewBindings;->findChildViewById(Landroid/view/View;I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/ImageView;

    .line 73
    .local v1, "ivImage":Landroid/widget/ImageView;
    if-eqz v1, :cond_3

    .line 77
    sget v0, Lcom/rokid/phone/R$id;->tvAnswer:I

    .line 78
    invoke-static {p0, v0}, Landroidx/viewbinding/ViewBindings;->findChildViewById(Landroid/view/View;I)Landroid/view/View;

    move-result-object v2

    move-object v8, v2

    check-cast v8, Landroid/widget/TextView;

    .line 79
    .local v8, "tvAnswer":Landroid/widget/TextView;
    if-eqz v8, :cond_2

    .line 83
    sget v0, Lcom/rokid/phone/R$id;->tvQuestion:I

    .line 84
    invoke-static {p0, v0}, Landroidx/viewbinding/ViewBindings;->findChildViewById(Landroid/view/View;I)Landroid/view/View;

    move-result-object v2

    move-object v9, v2

    check-cast v9, Landroid/widget/TextView;

    .line 85
    .local v9, "tvQuestion":Landroid/widget/TextView;
    if-eqz v9, :cond_1

    .line 89
    sget v0, Lcom/rokid/phone/R$id;->tvTime:I

    .line 90
    invoke-static {p0, v0}, Landroidx/viewbinding/ViewBindings;->findChildViewById(Landroid/view/View;I)Landroid/view/View;

    move-result-object v2

    move-object v10, v2

    check-cast v10, Landroid/widget/TextView;

    .line 91
    .local v10, "tvTime":Landroid/widget/TextView;
    if-eqz v10, :cond_0

    .line 95
    new-instance v11, Lcom/rokid/phone/databinding/ItemAiVisionRecordBinding;

    move-object v3, p0

    check-cast v3, Landroidx/constraintlayout/widget/ConstraintLayout;

    move-object v2, v11

    move-object v4, v1

    move-object v5, v8

    move-object v6, v9

    move-object v7, v10

    invoke-direct/range {v2 .. v7}, Lcom/rokid/phone/databinding/ItemAiVisionRecordBinding;-><init>(Landroidx/constraintlayout/widget/ConstraintLayout;Landroid/widget/ImageView;Landroid/widget/TextView;Landroid/widget/TextView;Landroid/widget/TextView;)V

    return-object v11

    .line 92
    :cond_0
    goto :goto_0

    .line 86
    .end local v10    # "tvTime":Landroid/widget/TextView;
    :cond_1
    goto :goto_0

    .line 80
    .end local v9    # "tvQuestion":Landroid/widget/TextView;
    :cond_2
    goto :goto_0

    .line 74
    .end local v8    # "tvAnswer":Landroid/widget/TextView;
    :cond_3
    nop

    .line 98
    .end local v1    # "ivImage":Landroid/widget/ImageView;
    :goto_0
    invoke-virtual {p0}, Landroid/view/View;->getResources()Landroid/content/res/Resources;

    move-result-object v1

    invoke-virtual {v1, v0}, Landroid/content/res/Resources;->getResourceName(I)Ljava/lang/String;

    move-result-object v1

    .line 99
    .local v1, "missingId":Ljava/lang/String;
    new-instance v2, Ljava/lang/NullPointerException;

    const-string v3, "Missing required view with ID: "

    invoke-virtual {v3, v1}, Ljava/lang/String;->concat(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    invoke-direct {v2, v3}, Ljava/lang/NullPointerException;-><init>(Ljava/lang/String;)V

    throw v2
.end method

.method public static inflate(Landroid/view/LayoutInflater;)Lcom/rokid/phone/databinding/ItemAiVisionRecordBinding;
    .locals 2
    .param p0, "inflater"    # Landroid/view/LayoutInflater;

    .line 52
    const/4 v0, 0x0

    const/4 v1, 0x0

    invoke-static {p0, v0, v1}, Lcom/rokid/phone/databinding/ItemAiVisionRecordBinding;->inflate(Landroid/view/LayoutInflater;Landroid/view/ViewGroup;Z)Lcom/rokid/phone/databinding/ItemAiVisionRecordBinding;

    move-result-object v0

    return-object v0
.end method

.method public static inflate(Landroid/view/LayoutInflater;Landroid/view/ViewGroup;Z)Lcom/rokid/phone/databinding/ItemAiVisionRecordBinding;
    .locals 2
    .param p0, "inflater"    # Landroid/view/LayoutInflater;
    .param p1, "parent"    # Landroid/view/ViewGroup;
    .param p2, "attachToParent"    # Z

    .line 58
    sget v0, Lcom/rokid/phone/R$layout;->item_ai_vision_record:I

    const/4 v1, 0x0

    invoke-virtual {p0, v0, p1, v1}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;Z)Landroid/view/View;

    move-result-object v0

    .line 59
    .local v0, "root":Landroid/view/View;
    if-eqz p2, :cond_0

    .line 60
    invoke-virtual {p1, v0}, Landroid/view/ViewGroup;->addView(Landroid/view/View;)V

    .line 62
    :cond_0
    invoke-static {v0}, Lcom/rokid/phone/databinding/ItemAiVisionRecordBinding;->bind(Landroid/view/View;)Lcom/rokid/phone/databinding/ItemAiVisionRecordBinding;

    move-result-object v1

    return-object v1
.end method


# virtual methods
.method public bridge synthetic getRoot()Landroid/view/View;
    .locals 1

    .line 19
    invoke-virtual {p0}, Lcom/rokid/phone/databinding/ItemAiVisionRecordBinding;->getRoot()Landroidx/constraintlayout/widget/ConstraintLayout;

    move-result-object v0

    return-object v0
.end method

.method public getRoot()Landroidx/constraintlayout/widget/ConstraintLayout;
    .locals 1

    .line 47
    iget-object v0, p0, Lcom/rokid/phone/databinding/ItemAiVisionRecordBinding;->rootView:Landroidx/constraintlayout/widget/ConstraintLayout;

    return-object v0
.end method
