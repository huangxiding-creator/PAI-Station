.class public final Lcom/rokid/phone/adapter/AiVisionAdapter;
.super Landroidx/recyclerview/widget/RecyclerView$Adapter;
.source "AiVisionAdapter.kt"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/rokid/phone/adapter/AiVisionAdapter$RecordViewHolder;
    }
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Landroidx/recyclerview/widget/RecyclerView$Adapter<",
        "Lcom/rokid/phone/adapter/AiVisionAdapter$RecordViewHolder;",
        ">;"
    }
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000>\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010 \n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0010\u000e\n\u0002\u0010\u0002\n\u0002\u0008\u0003\n\u0002\u0010!\n\u0002\u0008\u0005\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u0008\n\u0002\u0008\u0006\u0018\u00002\u0008\u0012\u0004\u0012\u00020\u00020\u0001:\u0001\u001aB-\u0012\u000e\u0008\u0002\u0010\u0003\u001a\u0008\u0012\u0004\u0012\u00020\u00050\u0004\u0012\u0014\u0008\u0002\u0010\u0006\u001a\u000e\u0012\u0004\u0012\u00020\u0008\u0012\u0004\u0012\u00020\t0\u0007\u00a2\u0006\u0004\u0008\n\u0010\u000bJ\u001e\u0010\u000f\u001a\u00020\t2\u000c\u0010\u0003\u001a\u0008\u0012\u0004\u0012\u00020\u00050\u00042\u0008\u0010\u0010\u001a\u0004\u0018\u00010\u0008J\u0018\u0010\u0011\u001a\u00020\u00022\u0006\u0010\u0012\u001a\u00020\u00132\u0006\u0010\u0014\u001a\u00020\u0015H\u0016J\u0018\u0010\u0016\u001a\u00020\t2\u0006\u0010\u0017\u001a\u00020\u00022\u0006\u0010\u0018\u001a\u00020\u0015H\u0016J\u0008\u0010\u0019\u001a\u00020\u0015H\u0016R\u001a\u0010\u0006\u001a\u000e\u0012\u0004\u0012\u00020\u0008\u0012\u0004\u0012\u00020\t0\u0007X\u0082\u0004\u00a2\u0006\u0002\n\u0000R\u0014\u0010\u000c\u001a\u0008\u0012\u0004\u0012\u00020\u00050\rX\u0082\u0004\u00a2\u0006\u0002\n\u0000R\u0010\u0010\u000e\u001a\u0004\u0018\u00010\u0008X\u0082\u000e\u00a2\u0006\u0002\n\u0000\u00a8\u0006\u001b"
    }
    d2 = {
        "Lcom/rokid/phone/adapter/AiVisionAdapter;",
        "Landroidx/recyclerview/widget/RecyclerView$Adapter;",
        "Lcom/rokid/phone/adapter/AiVisionAdapter$RecordViewHolder;",
        "records",
        "",
        "Lcom/rokid/phone/ai/AiVisionRecord;",
        "onRecordClick",
        "Lkotlin/Function1;",
        "",
        "",
        "<init>",
        "(Ljava/util/List;Lkotlin/jvm/functions/Function1;)V",
        "items",
        "",
        "selectedQuestionId",
        "submitRecords",
        "selectedId",
        "onCreateViewHolder",
        "parent",
        "Landroid/view/ViewGroup;",
        "viewType",
        "",
        "onBindViewHolder",
        "holder",
        "position",
        "getItemCount",
        "RecordViewHolder",
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
.field private final items:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lcom/rokid/phone/ai/AiVisionRecord;",
            ">;"
        }
    .end annotation
.end field

.field private final onRecordClick:Lkotlin/jvm/functions/Function1;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lkotlin/jvm/functions/Function1<",
            "Ljava/lang/String;",
            "Lkotlin/Unit;",
            ">;"
        }
    .end annotation
.end field

.field private selectedQuestionId:Ljava/lang/String;


# direct methods
.method public static synthetic $r8$lambda$EeqHxmm_ZDpa84yUs8B5Uyl12Jo(Lcom/rokid/phone/adapter/AiVisionAdapter;Lcom/rokid/phone/ai/AiVisionRecord;)Lkotlin/Unit;
    .locals 0

    invoke-static {p0, p1}, Lcom/rokid/phone/adapter/AiVisionAdapter;->onBindViewHolder$lambda$1(Lcom/rokid/phone/adapter/AiVisionAdapter;Lcom/rokid/phone/ai/AiVisionRecord;)Lkotlin/Unit;

    move-result-object p0

    return-object p0
.end method

.method public static synthetic $r8$lambda$PEeeylAmDwubXecoYwSdbRfmEKk(Ljava/lang/String;)Lkotlin/Unit;
    .locals 0

    invoke-static {p0}, Lcom/rokid/phone/adapter/AiVisionAdapter;->_init_$lambda$0(Ljava/lang/String;)Lkotlin/Unit;

    move-result-object p0

    return-object p0
.end method

.method public constructor <init>()V
    .locals 2

    const/4 v0, 0x0

    const/4 v1, 0x3

    invoke-direct {p0, v0, v0, v1, v0}, Lcom/rokid/phone/adapter/AiVisionAdapter;-><init>(Ljava/util/List;Lkotlin/jvm/functions/Function1;ILkotlin/jvm/internal/DefaultConstructorMarker;)V

    return-void
.end method

.method public constructor <init>(Ljava/util/List;Lkotlin/jvm/functions/Function1;)V
    .locals 1
    .param p1, "records"    # Ljava/util/List;
    .param p2, "onRecordClick"    # Lkotlin/jvm/functions/Function1;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lcom/rokid/phone/ai/AiVisionRecord;",
            ">;",
            "Lkotlin/jvm/functions/Function1<",
            "-",
            "Ljava/lang/String;",
            "Lkotlin/Unit;",
            ">;)V"
        }
    .end annotation

    const-string v0, "records"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "onRecordClick"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 24
    invoke-direct {p0}, Landroidx/recyclerview/widget/RecyclerView$Adapter;-><init>()V

    .line 23
    iput-object p2, p0, Lcom/rokid/phone/adapter/AiVisionAdapter;->onRecordClick:Lkotlin/jvm/functions/Function1;

    .line 25
    move-object v0, p1

    check-cast v0, Ljava/util/Collection;

    invoke-static {v0}, Lkotlin/collections/CollectionsKt;->toMutableList(Ljava/util/Collection;)Ljava/util/List;

    move-result-object v0

    iput-object v0, p0, Lcom/rokid/phone/adapter/AiVisionAdapter;->items:Ljava/util/List;

    .line 21
    return-void
.end method

.method public synthetic constructor <init>(Ljava/util/List;Lkotlin/jvm/functions/Function1;ILkotlin/jvm/internal/DefaultConstructorMarker;)V
    .locals 0

    .line 21
    and-int/lit8 p4, p3, 0x1

    if-eqz p4, :cond_0

    .line 22
    invoke-static {}, Lkotlin/collections/CollectionsKt;->emptyList()Ljava/util/List;

    move-result-object p1

    .line 21
    :cond_0
    and-int/lit8 p3, p3, 0x2

    if-eqz p3, :cond_1

    .line 23
    new-instance p2, Lcom/rokid/phone/adapter/AiVisionAdapter$$ExternalSyntheticLambda1;

    invoke-direct {p2}, Lcom/rokid/phone/adapter/AiVisionAdapter$$ExternalSyntheticLambda1;-><init>()V

    .line 21
    :cond_1
    invoke-direct {p0, p1, p2}, Lcom/rokid/phone/adapter/AiVisionAdapter;-><init>(Ljava/util/List;Lkotlin/jvm/functions/Function1;)V

    .line 24
    return-void
.end method

.method private static final _init_$lambda$0(Ljava/lang/String;)Lkotlin/Unit;
    .locals 1
    .param p0, "it"    # Ljava/lang/String;

    const-string v0, "it"

    invoke-static {p0, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 23
    sget-object v0, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    return-object v0
.end method

.method private static final onBindViewHolder$lambda$1(Lcom/rokid/phone/adapter/AiVisionAdapter;Lcom/rokid/phone/ai/AiVisionRecord;)Lkotlin/Unit;
    .locals 2
    .param p0, "this$0"    # Lcom/rokid/phone/adapter/AiVisionAdapter;
    .param p1, "$record"    # Lcom/rokid/phone/ai/AiVisionRecord;

    .line 49
    iget-object v0, p0, Lcom/rokid/phone/adapter/AiVisionAdapter;->onRecordClick:Lkotlin/jvm/functions/Function1;

    invoke-virtual {p1}, Lcom/rokid/phone/ai/AiVisionRecord;->getQuestionId()Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1}, Lkotlin/jvm/functions/Function1;->invoke(Ljava/lang/Object;)Ljava/lang/Object;

    .line 50
    sget-object v0, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    return-object v0
.end method


# virtual methods
.method public getItemCount()I
    .locals 1

    .line 53
    iget-object v0, p0, Lcom/rokid/phone/adapter/AiVisionAdapter;->items:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    return v0
.end method

.method public bridge synthetic onBindViewHolder(Landroidx/recyclerview/widget/RecyclerView$ViewHolder;I)V
    .locals 1
    .param p1, "p0"    # Landroidx/recyclerview/widget/RecyclerView$ViewHolder;
    .param p2, "p1"    # I

    .line 21
    move-object v0, p1

    check-cast v0, Lcom/rokid/phone/adapter/AiVisionAdapter$RecordViewHolder;

    invoke-virtual {p0, v0, p2}, Lcom/rokid/phone/adapter/AiVisionAdapter;->onBindViewHolder(Lcom/rokid/phone/adapter/AiVisionAdapter$RecordViewHolder;I)V

    return-void
.end method

.method public onBindViewHolder(Lcom/rokid/phone/adapter/AiVisionAdapter$RecordViewHolder;I)V
    .locals 3
    .param p1, "holder"    # Lcom/rokid/phone/adapter/AiVisionAdapter$RecordViewHolder;
    .param p2, "position"    # I

    const-string v0, "holder"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 47
    iget-object v0, p0, Lcom/rokid/phone/adapter/AiVisionAdapter;->items:Ljava/util/List;

    invoke-interface {v0, p2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/rokid/phone/ai/AiVisionRecord;

    .line 48
    .local v0, "record":Lcom/rokid/phone/ai/AiVisionRecord;
    invoke-virtual {v0}, Lcom/rokid/phone/ai/AiVisionRecord;->getQuestionId()Ljava/lang/String;

    move-result-object v1

    iget-object v2, p0, Lcom/rokid/phone/adapter/AiVisionAdapter;->selectedQuestionId:Ljava/lang/String;

    invoke-static {v1, v2}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v1

    new-instance v2, Lcom/rokid/phone/adapter/AiVisionAdapter$$ExternalSyntheticLambda0;

    invoke-direct {v2, p0, v0}, Lcom/rokid/phone/adapter/AiVisionAdapter$$ExternalSyntheticLambda0;-><init>(Lcom/rokid/phone/adapter/AiVisionAdapter;Lcom/rokid/phone/ai/AiVisionRecord;)V

    invoke-virtual {p1, v0, v1, v2}, Lcom/rokid/phone/adapter/AiVisionAdapter$RecordViewHolder;->bind(Lcom/rokid/phone/ai/AiVisionRecord;ZLkotlin/jvm/functions/Function0;)V

    .line 51
    return-void
.end method

.method public bridge synthetic onCreateViewHolder(Landroid/view/ViewGroup;I)Landroidx/recyclerview/widget/RecyclerView$ViewHolder;
    .locals 1
    .param p1, "p0"    # Landroid/view/ViewGroup;
    .param p2, "p1"    # I

    .line 21
    invoke-virtual {p0, p1, p2}, Lcom/rokid/phone/adapter/AiVisionAdapter;->onCreateViewHolder(Landroid/view/ViewGroup;I)Lcom/rokid/phone/adapter/AiVisionAdapter$RecordViewHolder;

    move-result-object v0

    check-cast v0, Landroidx/recyclerview/widget/RecyclerView$ViewHolder;

    return-object v0
.end method

.method public onCreateViewHolder(Landroid/view/ViewGroup;I)Lcom/rokid/phone/adapter/AiVisionAdapter$RecordViewHolder;
    .locals 2
    .param p1, "parent"    # Landroid/view/ViewGroup;
    .param p2, "viewType"    # I

    const-string v0, "parent"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 39
    invoke-virtual {p1}, Landroid/view/ViewGroup;->getContext()Landroid/content/Context;

    move-result-object v0

    invoke-static {v0}, Landroid/view/LayoutInflater;->from(Landroid/content/Context;)Landroid/view/LayoutInflater;

    move-result-object v0

    .line 40
    nop

    .line 41
    nop

    .line 38
    const/4 v1, 0x0

    invoke-static {v0, p1, v1}, Lcom/rokid/phone/databinding/ItemAiVisionRecordBinding;->inflate(Landroid/view/LayoutInflater;Landroid/view/ViewGroup;Z)Lcom/rokid/phone/databinding/ItemAiVisionRecordBinding;

    move-result-object v0

    const-string v1, "inflate(...)"

    invoke-static {v0, v1}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    .line 43
    .local v0, "binding":Lcom/rokid/phone/databinding/ItemAiVisionRecordBinding;
    new-instance v1, Lcom/rokid/phone/adapter/AiVisionAdapter$RecordViewHolder;

    invoke-direct {v1, v0}, Lcom/rokid/phone/adapter/AiVisionAdapter$RecordViewHolder;-><init>(Lcom/rokid/phone/databinding/ItemAiVisionRecordBinding;)V

    return-object v1
.end method

.method public final submitRecords(Ljava/util/List;Ljava/lang/String;)V
    .locals 3
    .param p1, "records"    # Ljava/util/List;
    .param p2, "selectedId"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lcom/rokid/phone/ai/AiVisionRecord;",
            ">;",
            "Ljava/lang/String;",
            ")V"
        }
    .end annotation

    const-string v0, "records"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 29
    iget-object v0, p0, Lcom/rokid/phone/adapter/AiVisionAdapter;->items:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    .line 30
    .local v0, "oldSize":I
    iget-object v1, p0, Lcom/rokid/phone/adapter/AiVisionAdapter;->items:Ljava/util/List;

    invoke-interface {v1}, Ljava/util/List;->clear()V

    .line 31
    iget-object v1, p0, Lcom/rokid/phone/adapter/AiVisionAdapter;->items:Ljava/util/List;

    move-object v2, p1

    check-cast v2, Ljava/util/Collection;

    invoke-interface {v1, v2}, Ljava/util/List;->addAll(Ljava/util/Collection;)Z

    .line 32
    iput-object p2, p0, Lcom/rokid/phone/adapter/AiVisionAdapter;->selectedQuestionId:Ljava/lang/String;

    .line 33
    const/4 v1, 0x0

    if-lez v0, :cond_0

    invoke-virtual {p0, v1, v0}, Lcom/rokid/phone/adapter/AiVisionAdapter;->notifyItemRangeRemoved(II)V

    .line 34
    :cond_0
    iget-object v2, p0, Lcom/rokid/phone/adapter/AiVisionAdapter;->items:Ljava/util/List;

    check-cast v2, Ljava/util/Collection;

    invoke-interface {v2}, Ljava/util/Collection;->isEmpty()Z

    move-result v2

    xor-int/lit8 v2, v2, 0x1

    if-eqz v2, :cond_1

    iget-object v2, p0, Lcom/rokid/phone/adapter/AiVisionAdapter;->items:Ljava/util/List;

    invoke-interface {v2}, Ljava/util/List;->size()I

    move-result v2

    invoke-virtual {p0, v1, v2}, Lcom/rokid/phone/adapter/AiVisionAdapter;->notifyItemRangeInserted(II)V

    .line 35
    :cond_1
    return-void
.end method
