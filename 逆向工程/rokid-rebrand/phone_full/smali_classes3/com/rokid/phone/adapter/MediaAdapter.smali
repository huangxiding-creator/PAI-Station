.class public final Lcom/rokid/phone/adapter/MediaAdapter;
.super Landroidx/recyclerview/widget/RecyclerView$Adapter;
.source "MediaAdapter.kt"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/rokid/phone/adapter/MediaAdapter$Holder;
    }
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Landroidx/recyclerview/widget/RecyclerView$Adapter<",
        "Lcom/rokid/phone/adapter/MediaAdapter$Holder;",
        ">;"
    }
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u00002\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010 \n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0010\u0002\n\u0002\u0008\u0004\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u0008\n\u0002\u0008\u0006\u0018\u00002\u0008\u0012\u0004\u0012\u00020\u00020\u0001:\u0001\u0014B)\u0012\u000c\u0010\u0003\u001a\u0008\u0012\u0004\u0012\u00020\u00050\u0004\u0012\u0012\u0010\u0006\u001a\u000e\u0012\u0004\u0012\u00020\u0005\u0012\u0004\u0012\u00020\u00080\u0007\u00a2\u0006\u0004\u0008\t\u0010\nJ\u0018\u0010\u000b\u001a\u00020\u00022\u0006\u0010\u000c\u001a\u00020\r2\u0006\u0010\u000e\u001a\u00020\u000fH\u0016J\u0018\u0010\u0010\u001a\u00020\u00082\u0006\u0010\u0011\u001a\u00020\u00022\u0006\u0010\u0012\u001a\u00020\u000fH\u0016J\u0008\u0010\u0013\u001a\u00020\u000fH\u0016R\u0014\u0010\u0003\u001a\u0008\u0012\u0004\u0012\u00020\u00050\u0004X\u0082\u0004\u00a2\u0006\u0002\n\u0000R\u001a\u0010\u0006\u001a\u000e\u0012\u0004\u0012\u00020\u0005\u0012\u0004\u0012\u00020\u00080\u0007X\u0082\u0004\u00a2\u0006\u0002\n\u0000\u00a8\u0006\u0015"
    }
    d2 = {
        "Lcom/rokid/phone/adapter/MediaAdapter;",
        "Landroidx/recyclerview/widget/RecyclerView$Adapter;",
        "Lcom/rokid/phone/adapter/MediaAdapter$Holder;",
        "files",
        "",
        "Ljava/io/File;",
        "onClick",
        "Lkotlin/Function1;",
        "",
        "<init>",
        "(Ljava/util/List;Lkotlin/jvm/functions/Function1;)V",
        "onCreateViewHolder",
        "parent",
        "Landroid/view/ViewGroup;",
        "viewType",
        "",
        "onBindViewHolder",
        "holder",
        "position",
        "getItemCount",
        "Holder",
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
.field private final files:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Ljava/io/File;",
            ">;"
        }
    .end annotation
.end field

.field private final onClick:Lkotlin/jvm/functions/Function1;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lkotlin/jvm/functions/Function1<",
            "Ljava/io/File;",
            "Lkotlin/Unit;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method public static synthetic $r8$lambda$kc5TdheDDTNYP25KgV_G97m7GxA(Lcom/rokid/phone/adapter/MediaAdapter;Ljava/io/File;Landroid/view/View;)V
    .locals 0

    invoke-static {p0, p1, p2}, Lcom/rokid/phone/adapter/MediaAdapter;->onBindViewHolder$lambda$0(Lcom/rokid/phone/adapter/MediaAdapter;Ljava/io/File;Landroid/view/View;)V

    return-void
.end method

.method public constructor <init>(Ljava/util/List;Lkotlin/jvm/functions/Function1;)V
    .locals 1
    .param p1, "files"    # Ljava/util/List;
    .param p2, "onClick"    # Lkotlin/jvm/functions/Function1;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "+",
            "Ljava/io/File;",
            ">;",
            "Lkotlin/jvm/functions/Function1<",
            "-",
            "Ljava/io/File;",
            "Lkotlin/Unit;",
            ">;)V"
        }
    .end annotation

    const-string v0, "files"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "onClick"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 13
    invoke-direct {p0}, Landroidx/recyclerview/widget/RecyclerView$Adapter;-><init>()V

    .line 11
    iput-object p1, p0, Lcom/rokid/phone/adapter/MediaAdapter;->files:Ljava/util/List;

    .line 12
    iput-object p2, p0, Lcom/rokid/phone/adapter/MediaAdapter;->onClick:Lkotlin/jvm/functions/Function1;

    .line 10
    return-void
.end method

.method private static final onBindViewHolder$lambda$0(Lcom/rokid/phone/adapter/MediaAdapter;Ljava/io/File;Landroid/view/View;)V
    .locals 1
    .param p0, "this$0"    # Lcom/rokid/phone/adapter/MediaAdapter;
    .param p1, "$file"    # Ljava/io/File;
    .param p2, "it"    # Landroid/view/View;

    .line 31
    iget-object v0, p0, Lcom/rokid/phone/adapter/MediaAdapter;->onClick:Lkotlin/jvm/functions/Function1;

    invoke-interface {v0, p1}, Lkotlin/jvm/functions/Function1;->invoke(Ljava/lang/Object;)Ljava/lang/Object;

    return-void
.end method


# virtual methods
.method public getItemCount()I
    .locals 1

    .line 34
    iget-object v0, p0, Lcom/rokid/phone/adapter/MediaAdapter;->files:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    return v0
.end method

.method public bridge synthetic onBindViewHolder(Landroidx/recyclerview/widget/RecyclerView$ViewHolder;I)V
    .locals 1
    .param p1, "p0"    # Landroidx/recyclerview/widget/RecyclerView$ViewHolder;
    .param p2, "p1"    # I

    .line 10
    move-object v0, p1

    check-cast v0, Lcom/rokid/phone/adapter/MediaAdapter$Holder;

    invoke-virtual {p0, v0, p2}, Lcom/rokid/phone/adapter/MediaAdapter;->onBindViewHolder(Lcom/rokid/phone/adapter/MediaAdapter$Holder;I)V

    return-void
.end method

.method public onBindViewHolder(Lcom/rokid/phone/adapter/MediaAdapter$Holder;I)V
    .locals 4
    .param p1, "holder"    # Lcom/rokid/phone/adapter/MediaAdapter$Holder;
    .param p2, "position"    # I

    const-string v0, "holder"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 25
    iget-object v0, p0, Lcom/rokid/phone/adapter/MediaAdapter;->files:Ljava/util/List;

    invoke-interface {v0, p2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/io/File;

    .line 26
    .local v0, "file":Ljava/io/File;
    invoke-virtual {p1}, Lcom/rokid/phone/adapter/MediaAdapter$Holder;->getBinding()Lcom/rokid/phone/databinding/ItemMediaBinding;

    move-result-object v1

    iget-object v1, v1, Lcom/rokid/phone/databinding/ItemMediaBinding;->tvType:Landroid/widget/TextView;

    invoke-static {v0}, Lkotlin/io/FilesKt;->getExtension(Ljava/io/File;)Ljava/lang/String;

    move-result-object v2

    sget-object v3, Ljava/util/Locale;->ROOT:Ljava/util/Locale;

    invoke-virtual {v2, v3}, Ljava/lang/String;->toUpperCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v2

    const-string v3, "toUpperCase(...)"

    invoke-static {v2, v3}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    check-cast v2, Ljava/lang/CharSequence;

    invoke-virtual {v1, v2}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 27
    invoke-virtual {p1}, Lcom/rokid/phone/adapter/MediaAdapter$Holder;->getBinding()Lcom/rokid/phone/databinding/ItemMediaBinding;

    move-result-object v1

    iget-object v1, v1, Lcom/rokid/phone/databinding/ItemMediaBinding;->ivMedia:Landroid/widget/ImageView;

    check-cast v1, Landroid/view/View;

    invoke-static {v1}, Lcom/bumptech/glide/Glide;->with(Landroid/view/View;)Lcom/bumptech/glide/RequestManager;

    move-result-object v1

    .line 28
    invoke-virtual {v1, v0}, Lcom/bumptech/glide/RequestManager;->load(Ljava/io/File;)Lcom/bumptech/glide/RequestBuilder;

    move-result-object v1

    .line 29
    invoke-virtual {v1}, Lcom/bumptech/glide/RequestBuilder;->centerCrop()Lcom/bumptech/glide/request/BaseRequestOptions;

    move-result-object v1

    check-cast v1, Lcom/bumptech/glide/RequestBuilder;

    .line 30
    invoke-virtual {p1}, Lcom/rokid/phone/adapter/MediaAdapter$Holder;->getBinding()Lcom/rokid/phone/databinding/ItemMediaBinding;

    move-result-object v2

    iget-object v2, v2, Lcom/rokid/phone/databinding/ItemMediaBinding;->ivMedia:Landroid/widget/ImageView;

    invoke-virtual {v1, v2}, Lcom/bumptech/glide/RequestBuilder;->into(Landroid/widget/ImageView;)Lcom/bumptech/glide/request/target/ViewTarget;

    .line 31
    invoke-virtual {p1}, Lcom/rokid/phone/adapter/MediaAdapter$Holder;->getBinding()Lcom/rokid/phone/databinding/ItemMediaBinding;

    move-result-object v1

    invoke-virtual {v1}, Lcom/rokid/phone/databinding/ItemMediaBinding;->getRoot()Landroid/widget/FrameLayout;

    move-result-object v1

    new-instance v2, Lcom/rokid/phone/adapter/MediaAdapter$$ExternalSyntheticLambda0;

    invoke-direct {v2, p0, v0}, Lcom/rokid/phone/adapter/MediaAdapter$$ExternalSyntheticLambda0;-><init>(Lcom/rokid/phone/adapter/MediaAdapter;Ljava/io/File;)V

    invoke-virtual {v1, v2}, Landroid/widget/FrameLayout;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 32
    return-void
.end method

.method public bridge synthetic onCreateViewHolder(Landroid/view/ViewGroup;I)Landroidx/recyclerview/widget/RecyclerView$ViewHolder;
    .locals 1
    .param p1, "p0"    # Landroid/view/ViewGroup;
    .param p2, "p1"    # I

    .line 10
    invoke-virtual {p0, p1, p2}, Lcom/rokid/phone/adapter/MediaAdapter;->onCreateViewHolder(Landroid/view/ViewGroup;I)Lcom/rokid/phone/adapter/MediaAdapter$Holder;

    move-result-object v0

    check-cast v0, Landroidx/recyclerview/widget/RecyclerView$ViewHolder;

    return-object v0
.end method

.method public onCreateViewHolder(Landroid/view/ViewGroup;I)Lcom/rokid/phone/adapter/MediaAdapter$Holder;
    .locals 2
    .param p1, "parent"    # Landroid/view/ViewGroup;
    .param p2, "viewType"    # I

    const-string v0, "parent"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 17
    invoke-virtual {p1}, Landroid/view/ViewGroup;->getContext()Landroid/content/Context;

    move-result-object v0

    invoke-static {v0}, Landroid/view/LayoutInflater;->from(Landroid/content/Context;)Landroid/view/LayoutInflater;

    move-result-object v0

    .line 18
    nop

    .line 19
    nop

    .line 16
    const/4 v1, 0x0

    invoke-static {v0, p1, v1}, Lcom/rokid/phone/databinding/ItemMediaBinding;->inflate(Landroid/view/LayoutInflater;Landroid/view/ViewGroup;Z)Lcom/rokid/phone/databinding/ItemMediaBinding;

    move-result-object v0

    const-string v1, "inflate(...)"

    invoke-static {v0, v1}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    .line 21
    .local v0, "binding":Lcom/rokid/phone/databinding/ItemMediaBinding;
    new-instance v1, Lcom/rokid/phone/adapter/MediaAdapter$Holder;

    invoke-direct {v1, v0}, Lcom/rokid/phone/adapter/MediaAdapter$Holder;-><init>(Lcom/rokid/phone/databinding/ItemMediaBinding;)V

    return-object v1
.end method
