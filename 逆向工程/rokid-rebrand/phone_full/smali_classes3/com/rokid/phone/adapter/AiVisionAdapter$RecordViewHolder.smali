.class public final Lcom/rokid/phone/adapter/AiVisionAdapter$RecordViewHolder;
.super Landroidx/recyclerview/widget/RecyclerView$ViewHolder;
.source "AiVisionAdapter.kt"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/rokid/phone/adapter/AiVisionAdapter;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "RecordViewHolder"
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u00000\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0003\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u000b\n\u0000\n\u0002\u0018\u0002\n\u0000\u0018\u00002\u00020\u0001B\u000f\u0012\u0006\u0010\u0002\u001a\u00020\u0003\u00a2\u0006\u0004\u0008\u0004\u0010\u0005J$\u0010\u0008\u001a\u00020\t2\u0006\u0010\n\u001a\u00020\u000b2\u0006\u0010\u000c\u001a\u00020\r2\u000c\u0010\u000e\u001a\u0008\u0012\u0004\u0012\u00020\t0\u000fR\u000e\u0010\u0002\u001a\u00020\u0003X\u0082\u0004\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0006\u001a\u00020\u0007X\u0082\u0004\u00a2\u0006\u0002\n\u0000\u00a8\u0006\u0010"
    }
    d2 = {
        "Lcom/rokid/phone/adapter/AiVisionAdapter$RecordViewHolder;",
        "Landroidx/recyclerview/widget/RecyclerView$ViewHolder;",
        "binding",
        "Lcom/rokid/phone/databinding/ItemAiVisionRecordBinding;",
        "<init>",
        "(Lcom/rokid/phone/databinding/ItemAiVisionRecordBinding;)V",
        "dateFormat",
        "Ljava/text/SimpleDateFormat;",
        "bind",
        "",
        "record",
        "Lcom/rokid/phone/ai/AiVisionRecord;",
        "selected",
        "",
        "onClick",
        "Lkotlin/Function0;",
        "app_debug"
    }
    k = 0x1
    mv = {
        0x2,
        0x2,
        0x0
    }
    xi = 0x30
.end annotation


# instance fields
.field private final binding:Lcom/rokid/phone/databinding/ItemAiVisionRecordBinding;

.field private final dateFormat:Ljava/text/SimpleDateFormat;


# direct methods
.method public static synthetic $r8$lambda$KusWmXE5-i-X8H76TGE3QaSDgBg(Lkotlin/jvm/functions/Function0;Landroid/view/View;)V
    .locals 0

    invoke-static {p0, p1}, Lcom/rokid/phone/adapter/AiVisionAdapter$RecordViewHolder;->bind$lambda$0(Lkotlin/jvm/functions/Function0;Landroid/view/View;)V

    return-void
.end method

.method public constructor <init>(Lcom/rokid/phone/databinding/ItemAiVisionRecordBinding;)V
    .locals 3
    .param p1, "binding"    # Lcom/rokid/phone/databinding/ItemAiVisionRecordBinding;

    const-string v0, "binding"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 57
    invoke-virtual {p1}, Lcom/rokid/phone/databinding/ItemAiVisionRecordBinding;->getRoot()Landroidx/constraintlayout/widget/ConstraintLayout;

    move-result-object v0

    check-cast v0, Landroid/view/View;

    invoke-direct {p0, v0}, Landroidx/recyclerview/widget/RecyclerView$ViewHolder;-><init>(Landroid/view/View;)V

    .line 56
    iput-object p1, p0, Lcom/rokid/phone/adapter/AiVisionAdapter$RecordViewHolder;->binding:Lcom/rokid/phone/databinding/ItemAiVisionRecordBinding;

    .line 58
    new-instance v0, Ljava/text/SimpleDateFormat;

    const-string v1, "yyyy-MM-dd HH:mm:ss"

    invoke-static {}, Ljava/util/Locale;->getDefault()Ljava/util/Locale;

    move-result-object v2

    invoke-direct {v0, v1, v2}, Ljava/text/SimpleDateFormat;-><init>(Ljava/lang/String;Ljava/util/Locale;)V

    iput-object v0, p0, Lcom/rokid/phone/adapter/AiVisionAdapter$RecordViewHolder;->dateFormat:Ljava/text/SimpleDateFormat;

    .line 55
    return-void
.end method

.method private static final bind$lambda$0(Lkotlin/jvm/functions/Function0;Landroid/view/View;)V
    .locals 0
    .param p0, "$onClick"    # Lkotlin/jvm/functions/Function0;
    .param p1, "it"    # Landroid/view/View;

    .line 70
    invoke-interface {p0}, Lkotlin/jvm/functions/Function0;->invoke()Ljava/lang/Object;

    return-void
.end method


# virtual methods
.method public final bind(Lcom/rokid/phone/ai/AiVisionRecord;ZLkotlin/jvm/functions/Function0;)V
    .locals 7
    .param p1, "record"    # Lcom/rokid/phone/ai/AiVisionRecord;
    .param p2, "selected"    # Z
    .param p3, "onClick"    # Lkotlin/jvm/functions/Function0;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/rokid/phone/ai/AiVisionRecord;",
            "Z",
            "Lkotlin/jvm/functions/Function0<",
            "Lkotlin/Unit;",
            ">;)V"
        }
    .end annotation

    const-string v0, "record"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "onClick"

    invoke-static {p3, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 61
    iget-object v0, p0, Lcom/rokid/phone/adapter/AiVisionAdapter$RecordViewHolder;->binding:Lcom/rokid/phone/databinding/ItemAiVisionRecordBinding;

    invoke-virtual {v0}, Lcom/rokid/phone/databinding/ItemAiVisionRecordBinding;->getRoot()Landroidx/constraintlayout/widget/ConstraintLayout;

    move-result-object v0

    invoke-virtual {v0}, Landroidx/constraintlayout/widget/ConstraintLayout;->getContext()Landroid/content/Context;

    move-result-object v0

    .line 62
    .local v0, "context":Landroid/content/Context;
    iget-object v1, p0, Lcom/rokid/phone/adapter/AiVisionAdapter$RecordViewHolder;->binding:Lcom/rokid/phone/databinding/ItemAiVisionRecordBinding;

    invoke-virtual {v1}, Lcom/rokid/phone/databinding/ItemAiVisionRecordBinding;->getRoot()Landroidx/constraintlayout/widget/ConstraintLayout;

    move-result-object v1

    invoke-virtual {v1, p2}, Landroidx/constraintlayout/widget/ConstraintLayout;->setSelected(Z)V

    .line 63
    iget-object v1, p0, Lcom/rokid/phone/adapter/AiVisionAdapter$RecordViewHolder;->binding:Lcom/rokid/phone/databinding/ItemAiVisionRecordBinding;

    invoke-virtual {v1}, Lcom/rokid/phone/databinding/ItemAiVisionRecordBinding;->getRoot()Landroidx/constraintlayout/widget/ConstraintLayout;

    move-result-object v1

    .line 64
    if-eqz p2, :cond_0

    .line 65
    sget v2, Lcom/rokid/phone/R$drawable;->bg_ai_vision_record_selected:I

    goto :goto_0

    .line 67
    :cond_0
    sget v2, Lcom/rokid/phone/R$drawable;->rounded_corner_bg:I

    .line 63
    :goto_0
    invoke-virtual {v1, v2}, Landroidx/constraintlayout/widget/ConstraintLayout;->setBackgroundResource(I)V

    .line 70
    iget-object v1, p0, Lcom/rokid/phone/adapter/AiVisionAdapter$RecordViewHolder;->binding:Lcom/rokid/phone/databinding/ItemAiVisionRecordBinding;

    invoke-virtual {v1}, Lcom/rokid/phone/databinding/ItemAiVisionRecordBinding;->getRoot()Landroidx/constraintlayout/widget/ConstraintLayout;

    move-result-object v1

    new-instance v2, Lcom/rokid/phone/adapter/AiVisionAdapter$RecordViewHolder$$ExternalSyntheticLambda0;

    invoke-direct {v2, p3}, Lcom/rokid/phone/adapter/AiVisionAdapter$RecordViewHolder$$ExternalSyntheticLambda0;-><init>(Lkotlin/jvm/functions/Function0;)V

    invoke-virtual {v1, v2}, Landroidx/constraintlayout/widget/ConstraintLayout;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 71
    iget-object v1, p0, Lcom/rokid/phone/adapter/AiVisionAdapter$RecordViewHolder;->binding:Lcom/rokid/phone/databinding/ItemAiVisionRecordBinding;

    iget-object v1, v1, Lcom/rokid/phone/databinding/ItemAiVisionRecordBinding;->tvTime:Landroid/widget/TextView;

    iget-object v2, p0, Lcom/rokid/phone/adapter/AiVisionAdapter$RecordViewHolder;->dateFormat:Ljava/text/SimpleDateFormat;

    new-instance v3, Ljava/util/Date;

    invoke-virtual {p1}, Lcom/rokid/phone/ai/AiVisionRecord;->getTimestamp()J

    move-result-wide v4

    invoke-direct {v3, v4, v5}, Ljava/util/Date;-><init>(J)V

    invoke-virtual {v2, v3}, Ljava/text/SimpleDateFormat;->format(Ljava/util/Date;)Ljava/lang/String;

    move-result-object v2

    check-cast v2, Ljava/lang/CharSequence;

    invoke-virtual {v1, v2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 72
    iget-object v1, p0, Lcom/rokid/phone/adapter/AiVisionAdapter$RecordViewHolder;->binding:Lcom/rokid/phone/databinding/ItemAiVisionRecordBinding;

    iget-object v1, v1, Lcom/rokid/phone/databinding/ItemAiVisionRecordBinding;->tvQuestion:Landroid/widget/TextView;

    .line 73
    sget v2, Lcom/rokid/phone/R$string;->demo_ai_vision_question:I

    .line 74
    invoke-virtual {p1}, Lcom/rokid/phone/ai/AiVisionRecord;->getQuestion()Ljava/lang/String;

    move-result-object v3

    check-cast v3, Ljava/lang/CharSequence;

    invoke-static {v3}, Lkotlin/text/StringsKt;->isBlank(Ljava/lang/CharSequence;)Z

    move-result v4

    const/4 v5, 0x0

    if-eqz v4, :cond_1

    const/4 v3, 0x0

    .line 75
    .local v3, "$i$a$-ifBlank-AiVisionAdapter$RecordViewHolder$bind$2":I
    sget v4, Lcom/rokid/phone/R$string;->demo_ai_vision_unknown_question:I

    new-array v6, v5, [Ljava/lang/Object;

    invoke-static {v4, v6}, Lcom/rokid/phone/utils/DemoStringsKt;->demoString(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    .line 74
    .end local v3    # "$i$a$-ifBlank-AiVisionAdapter$RecordViewHolder$bind$2":I
    nop

    :cond_1
    filled-new-array {v3}, [Ljava/lang/Object;

    move-result-object v3

    .line 72
    invoke-virtual {v0, v2, v3}, Landroid/content/Context;->getString(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    check-cast v2, Ljava/lang/CharSequence;

    invoke-virtual {v1, v2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 78
    iget-object v1, p0, Lcom/rokid/phone/adapter/AiVisionAdapter$RecordViewHolder;->binding:Lcom/rokid/phone/databinding/ItemAiVisionRecordBinding;

    iget-object v1, v1, Lcom/rokid/phone/databinding/ItemAiVisionRecordBinding;->tvAnswer:Landroid/widget/TextView;

    invoke-virtual {p1}, Lcom/rokid/phone/ai/AiVisionRecord;->getAnswer()Ljava/lang/String;

    move-result-object v2

    check-cast v2, Ljava/lang/CharSequence;

    invoke-static {v2}, Lkotlin/text/StringsKt;->isBlank(Ljava/lang/CharSequence;)Z

    move-result v3

    if-eqz v3, :cond_2

    const/4 v2, 0x0

    .line 79
    .local v2, "$i$a$-ifBlank-AiVisionAdapter$RecordViewHolder$bind$3":I
    sget v3, Lcom/rokid/phone/R$string;->demo_ai_vision_waiting:I

    new-array v4, v5, [Ljava/lang/Object;

    invoke-static {v3, v4}, Lcom/rokid/phone/utils/DemoStringsKt;->demoString(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    .line 78
    .end local v2    # "$i$a$-ifBlank-AiVisionAdapter$RecordViewHolder$bind$3":I
    nop

    :cond_2
    check-cast v2, Ljava/lang/CharSequence;

    invoke-virtual {v1, v2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 82
    invoke-virtual {p1}, Lcom/rokid/phone/ai/AiVisionRecord;->getImageUrl()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lcom/rokid/phone/ai/AiVisionStoreKt;->resolveAiVisionImageUri(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v1

    .line 83
    .local v1, "imageUri":Landroid/net/Uri;
    if-nez v1, :cond_3

    .line 84
    iget-object v2, p0, Lcom/rokid/phone/adapter/AiVisionAdapter$RecordViewHolder;->binding:Lcom/rokid/phone/databinding/ItemAiVisionRecordBinding;

    iget-object v2, v2, Lcom/rokid/phone/databinding/ItemAiVisionRecordBinding;->ivImage:Landroid/widget/ImageView;

    const/16 v3, 0x8

    invoke-virtual {v2, v3}, Landroid/widget/ImageView;->setVisibility(I)V

    .line 85
    iget-object v2, p0, Lcom/rokid/phone/adapter/AiVisionAdapter$RecordViewHolder;->binding:Lcom/rokid/phone/databinding/ItemAiVisionRecordBinding;

    iget-object v2, v2, Lcom/rokid/phone/databinding/ItemAiVisionRecordBinding;->ivImage:Landroid/widget/ImageView;

    check-cast v2, Landroid/view/View;

    invoke-static {v2}, Lcom/bumptech/glide/Glide;->with(Landroid/view/View;)Lcom/bumptech/glide/RequestManager;

    move-result-object v2

    iget-object v3, p0, Lcom/rokid/phone/adapter/AiVisionAdapter$RecordViewHolder;->binding:Lcom/rokid/phone/databinding/ItemAiVisionRecordBinding;

    iget-object v3, v3, Lcom/rokid/phone/databinding/ItemAiVisionRecordBinding;->ivImage:Landroid/widget/ImageView;

    check-cast v3, Landroid/view/View;

    invoke-virtual {v2, v3}, Lcom/bumptech/glide/RequestManager;->clear(Landroid/view/View;)V

    goto :goto_1

    .line 87
    :cond_3
    iget-object v2, p0, Lcom/rokid/phone/adapter/AiVisionAdapter$RecordViewHolder;->binding:Lcom/rokid/phone/databinding/ItemAiVisionRecordBinding;

    iget-object v2, v2, Lcom/rokid/phone/databinding/ItemAiVisionRecordBinding;->ivImage:Landroid/widget/ImageView;

    invoke-virtual {v2, v5}, Landroid/widget/ImageView;->setVisibility(I)V

    .line 88
    iget-object v2, p0, Lcom/rokid/phone/adapter/AiVisionAdapter$RecordViewHolder;->binding:Lcom/rokid/phone/databinding/ItemAiVisionRecordBinding;

    iget-object v2, v2, Lcom/rokid/phone/databinding/ItemAiVisionRecordBinding;->ivImage:Landroid/widget/ImageView;

    check-cast v2, Landroid/view/View;

    invoke-static {v2}, Lcom/bumptech/glide/Glide;->with(Landroid/view/View;)Lcom/bumptech/glide/RequestManager;

    move-result-object v2

    .line 89
    invoke-virtual {v2, v1}, Lcom/bumptech/glide/RequestManager;->load(Landroid/net/Uri;)Lcom/bumptech/glide/RequestBuilder;

    move-result-object v2

    .line 90
    invoke-virtual {v2}, Lcom/bumptech/glide/RequestBuilder;->centerCrop()Lcom/bumptech/glide/request/BaseRequestOptions;

    move-result-object v2

    check-cast v2, Lcom/bumptech/glide/RequestBuilder;

    .line 91
    iget-object v3, p0, Lcom/rokid/phone/adapter/AiVisionAdapter$RecordViewHolder;->binding:Lcom/rokid/phone/databinding/ItemAiVisionRecordBinding;

    iget-object v3, v3, Lcom/rokid/phone/databinding/ItemAiVisionRecordBinding;->ivImage:Landroid/widget/ImageView;

    invoke-virtual {v2, v3}, Lcom/bumptech/glide/RequestBuilder;->into(Landroid/widget/ImageView;)Lcom/bumptech/glide/request/target/ViewTarget;

    move-result-object v2

    .line 86
    invoke-static {v2}, Lkotlin/jvm/internal/Intrinsics;->checkNotNull(Ljava/lang/Object;)V

    .line 93
    :goto_1
    return-void
.end method
