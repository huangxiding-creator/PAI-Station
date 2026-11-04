.class public final Lcom/rokid/phone/GalleryActivity;
.super Lcom/rokid/phone/base/BaseActivity;
.source "GalleryActivity.kt"


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lcom/rokid/phone/base/BaseActivity<",
        "Lcom/rokid/phone/databinding/ActivityGalleryBinding;",
        ">;"
    }
.end annotation

.annotation system Ldalvik/annotation/SourceDebugExtension;
    value = "SMAP\nGalleryActivity.kt\nKotlin\n*S Kotlin\n*F\n+ 1 GalleryActivity.kt\ncom/rokid/phone/GalleryActivity\n+ 2 _Collections.kt\nkotlin/collections/CollectionsKt___CollectionsKt\n+ 3 fake.kt\nkotlin/jvm/internal/FakeKt\n*L\n1#1,123:1\n1068#2:124\n1374#2:125\n1460#2,5:126\n1669#2,8:131\n1#3:139\n*S KotlinDebug\n*F\n+ 1 GalleryActivity.kt\ncom/rokid/phone/GalleryActivity\n*L\n79#1:124\n86#1:125\n86#1:126,5\n90#1:131,8\n*E\n"
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000I\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0003\n\u0002\u0010!\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u000b\n\u0000\n\u0002\u0008\u0004\n\u0002\u0010\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0004\n\u0002\u0010 \n\u0002\u0008\u0005\n\u0002\u0010\u000e\n\u0000*\u0001\r\u0018\u00002\u0008\u0012\u0004\u0012\u00020\u00020\u0001B\u0007\u00a2\u0006\u0004\u0008\u0003\u0010\u0004J\u0008\u0010\u000f\u001a\u00020\u0002H\u0016J\u0012\u0010\u0010\u001a\u00020\u00112\u0008\u0010\u0012\u001a\u0004\u0018\u00010\u0013H\u0016J\u0008\u0010\u0014\u001a\u00020\u0011H\u0014J\u0008\u0010\u0015\u001a\u00020\u0011H\u0014J\u0008\u0010\u0016\u001a\u00020\u0011H\u0002J\u000e\u0010\u0017\u001a\u0008\u0012\u0004\u0012\u00020\u00070\u0018H\u0002J\u0010\u0010\u0019\u001a\u00020\u000b2\u0006\u0010\u001a\u001a\u00020\u0007H\u0002J\u0010\u0010\u001b\u001a\u00020\u00112\u0006\u0010\u001a\u001a\u00020\u0007H\u0002J\u0010\u0010\u001c\u001a\u00020\u00112\u0006\u0010\u001d\u001a\u00020\u001eH\u0002R\u0014\u0010\u0005\u001a\u0008\u0012\u0004\u0012\u00020\u00070\u0006X\u0082\u0004\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0008\u001a\u00020\tX\u0082.\u00a2\u0006\u0002\n\u0000R\u000e\u0010\n\u001a\u00020\u000bX\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u0010\u0010\u000c\u001a\u00020\rX\u0082\u0004\u00a2\u0006\u0004\n\u0002\u0010\u000e\u00a8\u0006\u001f"
    }
    d2 = {
        "Lcom/rokid/phone/GalleryActivity;",
        "Lcom/rokid/phone/base/BaseActivity;",
        "Lcom/rokid/phone/databinding/ActivityGalleryBinding;",
        "<init>",
        "()V",
        "media",
        "",
        "Ljava/io/File;",
        "adapter",
        "Lcom/rokid/phone/adapter/MediaAdapter;",
        "listening",
        "",
        "fileListener",
        "com/rokid/phone/GalleryActivity$fileListener$1",
        "Lcom/rokid/phone/GalleryActivity$fileListener$1;",
        "initViewBinding",
        "onInit",
        "",
        "savedInstanceState",
        "Landroid/os/Bundle;",
        "onStart",
        "onStop",
        "loadMedia",
        "directMediaFiles",
        "",
        "isMedia",
        "file",
        "openMedia",
        "showProgress",
        "message",
        "",
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
.field private adapter:Lcom/rokid/phone/adapter/MediaAdapter;

.field private final fileListener:Lcom/rokid/phone/GalleryActivity$fileListener$1;

.field private listening:Z

.field private final media:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Ljava/io/File;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method public static synthetic $r8$lambda$XbwWL_3DTLDlbQ8Hl886gJXAMHk(Lcom/rokid/phone/GalleryActivity;Ljava/io/File;)Z
    .locals 0

    invoke-static {p0, p1}, Lcom/rokid/phone/GalleryActivity;->directMediaFiles$lambda$3$lambda$2(Lcom/rokid/phone/GalleryActivity;Ljava/io/File;)Z

    move-result p0

    return p0
.end method

.method public static synthetic $r8$lambda$pQagp7Fr_zGcee3jE0Fd6j7Mtj4(Lcom/rokid/phone/GalleryActivity;Landroid/view/View;)V
    .locals 0

    invoke-static {p0, p1}, Lcom/rokid/phone/GalleryActivity;->onInit$lambda$0(Lcom/rokid/phone/GalleryActivity;Landroid/view/View;)V

    return-void
.end method

.method public constructor <init>()V
    .locals 1

    .line 18
    invoke-direct {p0}, Lcom/rokid/phone/base/BaseActivity;-><init>()V

    .line 19
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    check-cast v0, Ljava/util/List;

    iput-object v0, p0, Lcom/rokid/phone/GalleryActivity;->media:Ljava/util/List;

    .line 23
    new-instance v0, Lcom/rokid/phone/GalleryActivity$fileListener$1;

    invoke-direct {v0, p0}, Lcom/rokid/phone/GalleryActivity$fileListener$1;-><init>(Lcom/rokid/phone/GalleryActivity;)V

    iput-object v0, p0, Lcom/rokid/phone/GalleryActivity;->fileListener:Lcom/rokid/phone/GalleryActivity$fileListener$1;

    .line 18
    return-void
.end method

.method public static final synthetic access$getBinding(Lcom/rokid/phone/GalleryActivity;)Lcom/rokid/phone/databinding/ActivityGalleryBinding;
    .locals 1
    .param p0, "$this"    # Lcom/rokid/phone/GalleryActivity;

    .line 18
    invoke-virtual {p0}, Lcom/rokid/phone/GalleryActivity;->getBinding()Landroidx/viewbinding/ViewBinding;

    move-result-object v0

    check-cast v0, Lcom/rokid/phone/databinding/ActivityGalleryBinding;

    return-object v0
.end method

.method public static final synthetic access$loadMedia(Lcom/rokid/phone/GalleryActivity;)V
    .locals 0
    .param p0, "$this"    # Lcom/rokid/phone/GalleryActivity;

    .line 18
    invoke-direct {p0}, Lcom/rokid/phone/GalleryActivity;->loadMedia()V

    return-void
.end method

.method public static final synthetic access$openMedia(Lcom/rokid/phone/GalleryActivity;Ljava/io/File;)V
    .locals 0
    .param p0, "$this"    # Lcom/rokid/phone/GalleryActivity;
    .param p1, "file"    # Ljava/io/File;

    .line 18
    invoke-direct {p0, p1}, Lcom/rokid/phone/GalleryActivity;->openMedia(Ljava/io/File;)V

    return-void
.end method

.method public static final synthetic access$showProgress(Lcom/rokid/phone/GalleryActivity;Ljava/lang/String;)V
    .locals 0
    .param p0, "$this"    # Lcom/rokid/phone/GalleryActivity;
    .param p1, "message"    # Ljava/lang/String;

    .line 18
    invoke-direct {p0, p1}, Lcom/rokid/phone/GalleryActivity;->showProgress(Ljava/lang/String;)V

    return-void
.end method

.method private final directMediaFiles()Ljava/util/List;
    .locals 12
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Ljava/io/File;",
            ">;"
        }
    .end annotation

    .line 85
    const/4 v0, 0x2

    new-array v0, v0, [Ljava/io/File;

    const/4 v1, 0x0

    invoke-virtual {p0, v1}, Lcom/rokid/phone/GalleryActivity;->getExternalFilesDir(Ljava/lang/String;)Ljava/io/File;

    move-result-object v1

    const/4 v2, 0x0

    aput-object v1, v0, v2

    const/4 v1, 0x1

    invoke-virtual {p0}, Lcom/rokid/phone/GalleryActivity;->getFilesDir()Ljava/io/File;

    move-result-object v2

    aput-object v2, v0, v1

    invoke-static {v0}, Lkotlin/collections/CollectionsKt;->listOfNotNull([Ljava/lang/Object;)Ljava/util/List;

    move-result-object v0

    .line 86
    .local v0, "roots":Ljava/util/List;
    move-object v1, v0

    check-cast v1, Ljava/lang/Iterable;

    .local v1, "$this$flatMap$iv":Ljava/lang/Iterable;
    const/4 v2, 0x0

    .line 125
    .local v2, "$i$f$flatMap":I
    new-instance v3, Ljava/util/ArrayList;

    invoke-direct {v3}, Ljava/util/ArrayList;-><init>()V

    check-cast v3, Ljava/util/Collection;

    .local v3, "destination$iv$iv":Ljava/util/Collection;
    move-object v4, v1

    .local v4, "$this$flatMapTo$iv$iv":Ljava/lang/Iterable;
    const/4 v5, 0x0

    .line 126
    .local v5, "$i$f$flatMapTo":I
    invoke-interface {v4}, Ljava/lang/Iterable;->iterator()Ljava/util/Iterator;

    move-result-object v6

    :goto_0
    invoke-interface {v6}, Ljava/util/Iterator;->hasNext()Z

    move-result v7

    if-eqz v7, :cond_0

    invoke-interface {v6}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v7

    .line 127
    .local v7, "element$iv$iv":Ljava/lang/Object;
    move-object v8, v7

    check-cast v8, Ljava/io/File;

    .local v8, "root":Ljava/io/File;
    const/4 v9, 0x0

    .line 87
    .local v9, "$i$a$-flatMap-GalleryActivity$directMediaFiles$1":I
    invoke-static {v8}, Lkotlin/io/FilesKt;->walkTopDown(Ljava/io/File;)Lkotlin/io/FileTreeWalk;

    move-result-object v10

    check-cast v10, Lkotlin/sequences/Sequence;

    .line 88
    new-instance v11, Lcom/rokid/phone/GalleryActivity$$ExternalSyntheticLambda0;

    invoke-direct {v11, p0}, Lcom/rokid/phone/GalleryActivity$$ExternalSyntheticLambda0;-><init>(Lcom/rokid/phone/GalleryActivity;)V

    invoke-static {v10, v11}, Lkotlin/sequences/SequencesKt;->filter(Lkotlin/sequences/Sequence;Lkotlin/jvm/functions/Function1;)Lkotlin/sequences/Sequence;

    move-result-object v10

    .line 89
    invoke-static {v10}, Lkotlin/sequences/SequencesKt;->toList(Lkotlin/sequences/Sequence;)Ljava/util/List;

    move-result-object v10

    check-cast v10, Ljava/lang/Iterable;

    .line 127
    .end local v8    # "root":Ljava/io/File;
    .end local v9    # "$i$a$-flatMap-GalleryActivity$directMediaFiles$1":I
    move-object v8, v10

    .line 128
    .local v8, "list$iv$iv":Ljava/lang/Iterable;
    invoke-static {v3, v8}, Lkotlin/collections/CollectionsKt;->addAll(Ljava/util/Collection;Ljava/lang/Iterable;)Z

    .end local v8    # "list$iv$iv":Ljava/lang/Iterable;
    goto :goto_0

    .line 130
    .end local v7    # "element$iv$iv":Ljava/lang/Object;
    :cond_0
    nop

    .end local v3    # "destination$iv$iv":Ljava/util/Collection;
    .end local v4    # "$this$flatMapTo$iv$iv":Ljava/lang/Iterable;
    .end local v5    # "$i$f$flatMapTo":I
    check-cast v3, Ljava/util/List;

    .line 125
    nop

    .end local v1    # "$this$flatMap$iv":Ljava/lang/Iterable;
    .end local v2    # "$i$f$flatMap":I
    check-cast v3, Ljava/lang/Iterable;

    .line 90
    move-object v1, v3

    .local v1, "$this$distinctBy$iv":Ljava/lang/Iterable;
    const/4 v2, 0x0

    .line 131
    .local v2, "$i$f$distinctBy":I
    new-instance v3, Ljava/util/HashSet;

    invoke-direct {v3}, Ljava/util/HashSet;-><init>()V

    .line 132
    .local v3, "set$iv":Ljava/util/HashSet;
    new-instance v4, Ljava/util/ArrayList;

    invoke-direct {v4}, Ljava/util/ArrayList;-><init>()V

    .line 133
    .local v4, "list$iv":Ljava/util/ArrayList;
    invoke-interface {v1}, Ljava/lang/Iterable;->iterator()Ljava/util/Iterator;

    move-result-object v5

    :cond_1
    :goto_1
    invoke-interface {v5}, Ljava/util/Iterator;->hasNext()Z

    move-result v6

    if-eqz v6, :cond_2

    invoke-interface {v5}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v6

    .line 134
    .local v6, "e$iv":Ljava/lang/Object;
    move-object v7, v6

    check-cast v7, Ljava/io/File;

    .local v7, "it":Ljava/io/File;
    const/4 v8, 0x0

    .line 90
    .local v8, "$i$a$-distinctBy-GalleryActivity$directMediaFiles$2":I
    invoke-virtual {v7}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v7

    .line 134
    .end local v7    # "it":Ljava/io/File;
    .end local v8    # "$i$a$-distinctBy-GalleryActivity$directMediaFiles$2":I
    nop

    .line 135
    .local v7, "key$iv":Ljava/lang/Object;
    invoke-virtual {v3, v7}, Ljava/util/HashSet;->add(Ljava/lang/Object;)Z

    move-result v8

    if-eqz v8, :cond_1

    .line 136
    invoke-virtual {v4, v6}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    goto :goto_1

    .line 138
    .end local v6    # "e$iv":Ljava/lang/Object;
    .end local v7    # "key$iv":Ljava/lang/Object;
    :cond_2
    move-object v1, v4

    check-cast v1, Ljava/util/List;

    .line 86
    .end local v1    # "$this$distinctBy$iv":Ljava/lang/Iterable;
    .end local v2    # "$i$f$distinctBy":I
    .end local v3    # "set$iv":Ljava/util/HashSet;
    .end local v4    # "list$iv":Ljava/util/ArrayList;
    return-object v1
.end method

.method private static final directMediaFiles$lambda$3$lambda$2(Lcom/rokid/phone/GalleryActivity;Ljava/io/File;)Z
    .locals 1
    .param p0, "this$0"    # Lcom/rokid/phone/GalleryActivity;
    .param p1, "it"    # Ljava/io/File;

    const-string v0, "it"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 88
    invoke-virtual {p1}, Ljava/io/File;->isFile()Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-direct {p0, p1}, Lcom/rokid/phone/GalleryActivity;->isMedia(Ljava/io/File;)Z

    move-result v0

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method

.method private final isMedia(Ljava/io/File;)Z
    .locals 4
    .param p1, "file"    # Ljava/io/File;

    .line 94
    invoke-static {p1}, Lkotlin/io/FilesKt;->getExtension(Ljava/io/File;)Ljava/lang/String;

    move-result-object v0

    sget-object v1, Ljava/util/Locale;->ROOT:Ljava/util/Locale;

    invoke-virtual {v0, v1}, Ljava/lang/String;->toLowerCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v0

    const-string v1, "toLowerCase(...)"

    invoke-static {v0, v1}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    .line 95
    .local v0, "extension":Ljava/lang/String;
    const/4 v1, 0x7

    new-array v1, v1, [Ljava/lang/String;

    const/4 v2, 0x0

    const-string v3, "jpg"

    aput-object v3, v1, v2

    const/4 v2, 0x1

    const-string v3, "jpeg"

    aput-object v3, v1, v2

    const/4 v2, 0x2

    const-string v3, "png"

    aput-object v3, v1, v2

    const/4 v2, 0x3

    const-string v3, "webp"

    aput-object v3, v1, v2

    const/4 v2, 0x4

    const-string v3, "mp4"

    aput-object v3, v1, v2

    const/4 v2, 0x5

    const-string v3, "mov"

    aput-object v3, v1, v2

    const/4 v2, 0x6

    const-string v3, "avi"

    aput-object v3, v1, v2

    invoke-static {v1}, Lkotlin/collections/SetsKt;->setOf([Ljava/lang/Object;)Ljava/util/Set;

    move-result-object v1

    invoke-interface {v1, v0}, Ljava/util/Set;->contains(Ljava/lang/Object;)Z

    move-result v1

    return v1
.end method

.method private final loadMedia()V
    .locals 5

    .line 77
    invoke-direct {p0}, Lcom/rokid/phone/GalleryActivity;->directMediaFiles()Ljava/util/List;

    move-result-object v0

    .line 78
    .local v0, "files":Ljava/util/List;
    iget-object v1, p0, Lcom/rokid/phone/GalleryActivity;->media:Ljava/util/List;

    invoke-interface {v1}, Ljava/util/List;->clear()V

    .line 79
    iget-object v1, p0, Lcom/rokid/phone/GalleryActivity;->media:Ljava/util/List;

    move-object v2, v0

    check-cast v2, Ljava/lang/Iterable;

    .local v2, "$this$sortedByDescending$iv":Ljava/lang/Iterable;
    const/4 v3, 0x0

    .line 124
    .local v3, "$i$f$sortedByDescending":I
    new-instance v4, Lcom/rokid/phone/GalleryActivity$loadMedia$$inlined$sortedByDescending$1;

    invoke-direct {v4}, Lcom/rokid/phone/GalleryActivity$loadMedia$$inlined$sortedByDescending$1;-><init>()V

    check-cast v4, Ljava/util/Comparator;

    invoke-static {v2, v4}, Lkotlin/collections/CollectionsKt;->sortedWith(Ljava/lang/Iterable;Ljava/util/Comparator;)Ljava/util/List;

    move-result-object v2

    .end local v2    # "$this$sortedByDescending$iv":Ljava/lang/Iterable;
    .end local v3    # "$i$f$sortedByDescending":I
    check-cast v2, Ljava/util/Collection;

    .line 79
    invoke-interface {v1, v2}, Ljava/util/List;->addAll(Ljava/util/Collection;)Z

    .line 80
    iget-object v1, p0, Lcom/rokid/phone/GalleryActivity;->adapter:Lcom/rokid/phone/adapter/MediaAdapter;

    if-nez v1, :cond_0

    const-string v1, "adapter"

    invoke-static {v1}, Lkotlin/jvm/internal/Intrinsics;->throwUninitializedPropertyAccessException(Ljava/lang/String;)V

    const/4 v1, 0x0

    :cond_0
    invoke-virtual {v1}, Lcom/rokid/phone/adapter/MediaAdapter;->notifyDataSetChanged()V

    .line 81
    invoke-virtual {p0}, Lcom/rokid/phone/GalleryActivity;->getBinding()Landroidx/viewbinding/ViewBinding;

    move-result-object v1

    check-cast v1, Lcom/rokid/phone/databinding/ActivityGalleryBinding;

    iget-object v1, v1, Lcom/rokid/phone/databinding/ActivityGalleryBinding;->tvEmpty:Landroid/widget/TextView;

    iget-object v2, p0, Lcom/rokid/phone/GalleryActivity;->media:Ljava/util/List;

    invoke-interface {v2}, Ljava/util/List;->isEmpty()Z

    move-result v2

    if-eqz v2, :cond_1

    const/4 v2, 0x0

    goto :goto_0

    :cond_1
    const/16 v2, 0x8

    :goto_0
    invoke-virtual {v1, v2}, Landroid/widget/TextView;->setVisibility(I)V

    .line 82
    return-void
.end method

.method private static final onInit$lambda$0(Lcom/rokid/phone/GalleryActivity;Landroid/view/View;)V
    .locals 0
    .param p0, "this$0"    # Lcom/rokid/phone/GalleryActivity;
    .param p1, "it"    # Landroid/view/View;

    .line 53
    invoke-virtual {p0}, Lcom/rokid/phone/GalleryActivity;->finish()V

    return-void
.end method

.method private final openMedia(Ljava/io/File;)V
    .locals 8
    .param p1, "file"    # Ljava/io/File;

    .line 99
    const/4 v0, 0x3

    new-array v0, v0, [Ljava/lang/String;

    const-string v1, "mp4"

    const/4 v2, 0x0

    aput-object v1, v0, v2

    const-string v1, "mov"

    const/4 v3, 0x1

    aput-object v1, v0, v3

    const/4 v1, 0x2

    const-string v4, "avi"

    aput-object v4, v0, v1

    invoke-static {v0}, Lkotlin/collections/SetsKt;->setOf([Ljava/lang/Object;)Ljava/util/Set;

    move-result-object v0

    invoke-static {p1}, Lkotlin/io/FilesKt;->getExtension(Ljava/io/File;)Ljava/lang/String;

    move-result-object v1

    sget-object v4, Ljava/util/Locale;->ROOT:Ljava/util/Locale;

    invoke-virtual {v1, v4}, Ljava/lang/String;->toLowerCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v1

    const-string v4, "toLowerCase(...)"

    invoke-static {v1, v4}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-interface {v0, v1}, Ljava/util/Set;->contains(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 100
    const-string v0, "video/*"

    goto :goto_0

    .line 102
    :cond_0
    const-string v0, "image/*"

    .line 99
    :goto_0
    nop

    .line 105
    .local v0, "mime":Ljava/lang/String;
    move-object v1, p0

    check-cast v1, Landroid/content/Context;

    .line 106
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p0}, Lcom/rokid/phone/GalleryActivity;->getPackageName()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, ".fileprovider"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    .line 107
    nop

    .line 104
    invoke-static {v1, v4, p1}, Landroidx/core/content/FileProvider;->getUriForFile(Landroid/content/Context;Ljava/lang/String;Ljava/io/File;)Landroid/net/Uri;

    move-result-object v1

    const-string v4, "getUriForFile(...)"

    invoke-static {v1, v4}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    .line 109
    .local v1, "uri":Landroid/net/Uri;
    new-instance v4, Landroid/content/Intent;

    const-string v5, "android.intent.action.VIEW"

    invoke-direct {v4, v5}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    move-object v5, v4

    .local v5, "$this$openMedia_u24lambda_u245":Landroid/content/Intent;
    const/4 v6, 0x0

    .line 110
    .local v6, "$i$a$-apply-GalleryActivity$openMedia$intent$1":I
    invoke-virtual {v5, v1, v0}, Landroid/content/Intent;->setDataAndType(Landroid/net/Uri;Ljava/lang/String;)Landroid/content/Intent;

    .line 111
    invoke-virtual {v5, v3}, Landroid/content/Intent;->addFlags(I)Landroid/content/Intent;

    .line 112
    nop

    .line 109
    .end local v5    # "$this$openMedia_u24lambda_u245":Landroid/content/Intent;
    .end local v6    # "$i$a$-apply-GalleryActivity$openMedia$intent$1":I
    move-object v3, v4

    .line 113
    .local v3, "intent":Landroid/content/Intent;
    :try_start_0
    sget-object v4, Lkotlin/Result;->Companion:Lkotlin/Result$Companion;

    move-object v4, p0

    check-cast v4, Lcom/rokid/phone/GalleryActivity;

    .line 139
    .local v4, "$this$openMedia_u24lambda_u246":Lcom/rokid/phone/GalleryActivity;
    const/4 v5, 0x0

    .line 113
    .local v5, "$i$a$-runCatching-GalleryActivity$openMedia$1":I
    invoke-virtual {v4, v3}, Lcom/rokid/phone/GalleryActivity;->startActivity(Landroid/content/Intent;)V

    .end local v4    # "$this$openMedia_u24lambda_u246":Lcom/rokid/phone/GalleryActivity;
    .end local v5    # "$i$a$-runCatching-GalleryActivity$openMedia$1":I
    sget-object v4, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    invoke-static {v4}, Lkotlin/Result;->constructor-impl(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v4
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto :goto_1

    :catchall_0
    move-exception v4

    sget-object v5, Lkotlin/Result;->Companion:Lkotlin/Result$Companion;

    invoke-static {v4}, Lkotlin/ResultKt;->createFailure(Ljava/lang/Throwable;)Ljava/lang/Object;

    move-result-object v4

    invoke-static {v4}, Lkotlin/Result;->constructor-impl(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v4

    :goto_1
    invoke-static {v4}, Lkotlin/Result;->exceptionOrNull-impl(Ljava/lang/Object;)Ljava/lang/Throwable;

    move-result-object v4

    if-eqz v4, :cond_1

    .local v4, "it":Ljava/lang/Throwable;
    const/4 v5, 0x0

    .line 114
    .local v5, "$i$a$-onFailure-GalleryActivity$openMedia$2":I
    move-object v6, p0

    check-cast v6, Landroid/content/Context;

    sget v7, Lcom/rokid/phone/R$string;->demo_no_media_app:I

    invoke-static {v6, v7, v2}, Landroid/widget/Toast;->makeText(Landroid/content/Context;II)Landroid/widget/Toast;

    move-result-object v2

    invoke-virtual {v2}, Landroid/widget/Toast;->show()V

    .line 115
    nop

    .line 113
    .end local v4    # "it":Ljava/lang/Throwable;
    .end local v5    # "$i$a$-onFailure-GalleryActivity$openMedia$2":I
    nop

    .line 116
    :cond_1
    return-void
.end method

.method private final showProgress(Ljava/lang/String;)V
    .locals 2
    .param p1, "message"    # Ljava/lang/String;

    .line 119
    invoke-virtual {p0}, Lcom/rokid/phone/GalleryActivity;->getBinding()Landroidx/viewbinding/ViewBinding;

    move-result-object v0

    check-cast v0, Lcom/rokid/phone/databinding/ActivityGalleryBinding;

    iget-object v0, v0, Lcom/rokid/phone/databinding/ActivityGalleryBinding;->receiveProgress:Landroid/widget/TextView;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setVisibility(I)V

    .line 120
    invoke-virtual {p0}, Lcom/rokid/phone/GalleryActivity;->getBinding()Landroidx/viewbinding/ViewBinding;

    move-result-object v0

    check-cast v0, Lcom/rokid/phone/databinding/ActivityGalleryBinding;

    iget-object v0, v0, Lcom/rokid/phone/databinding/ActivityGalleryBinding;->receiveProgress:Landroid/widget/TextView;

    move-object v1, p1

    check-cast v1, Ljava/lang/CharSequence;

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 121
    return-void
.end method


# virtual methods
.method public bridge synthetic initViewBinding()Landroidx/viewbinding/ViewBinding;
    .locals 1

    .line 18
    invoke-virtual {p0}, Lcom/rokid/phone/GalleryActivity;->initViewBinding()Lcom/rokid/phone/databinding/ActivityGalleryBinding;

    move-result-object v0

    check-cast v0, Landroidx/viewbinding/ViewBinding;

    return-object v0
.end method

.method public initViewBinding()Lcom/rokid/phone/databinding/ActivityGalleryBinding;
    .locals 2

    .line 47
    invoke-virtual {p0}, Lcom/rokid/phone/GalleryActivity;->getLayoutInflater()Landroid/view/LayoutInflater;

    move-result-object v0

    invoke-static {v0}, Lcom/rokid/phone/databinding/ActivityGalleryBinding;->inflate(Landroid/view/LayoutInflater;)Lcom/rokid/phone/databinding/ActivityGalleryBinding;

    move-result-object v0

    const-string v1, "inflate(...)"

    invoke-static {v0, v1}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    return-object v0
.end method

.method public onInit(Landroid/os/Bundle;)V
    .locals 4
    .param p1, "savedInstanceState"    # Landroid/os/Bundle;

    .line 50
    new-instance v0, Lcom/rokid/phone/adapter/MediaAdapter;

    iget-object v1, p0, Lcom/rokid/phone/GalleryActivity;->media:Ljava/util/List;

    new-instance v2, Lcom/rokid/phone/GalleryActivity$onInit$1;

    invoke-direct {v2, p0}, Lcom/rokid/phone/GalleryActivity$onInit$1;-><init>(Ljava/lang/Object;)V

    check-cast v2, Lkotlin/jvm/functions/Function1;

    invoke-direct {v0, v1, v2}, Lcom/rokid/phone/adapter/MediaAdapter;-><init>(Ljava/util/List;Lkotlin/jvm/functions/Function1;)V

    iput-object v0, p0, Lcom/rokid/phone/GalleryActivity;->adapter:Lcom/rokid/phone/adapter/MediaAdapter;

    .line 51
    invoke-virtual {p0}, Lcom/rokid/phone/GalleryActivity;->getBinding()Landroidx/viewbinding/ViewBinding;

    move-result-object v0

    check-cast v0, Lcom/rokid/phone/databinding/ActivityGalleryBinding;

    iget-object v0, v0, Lcom/rokid/phone/databinding/ActivityGalleryBinding;->recyclerView:Landroidx/recyclerview/widget/RecyclerView;

    new-instance v1, Landroidx/recyclerview/widget/GridLayoutManager;

    move-object v2, p0

    check-cast v2, Landroid/content/Context;

    const/4 v3, 0x3

    invoke-direct {v1, v2, v3}, Landroidx/recyclerview/widget/GridLayoutManager;-><init>(Landroid/content/Context;I)V

    check-cast v1, Landroidx/recyclerview/widget/RecyclerView$LayoutManager;

    invoke-virtual {v0, v1}, Landroidx/recyclerview/widget/RecyclerView;->setLayoutManager(Landroidx/recyclerview/widget/RecyclerView$LayoutManager;)V

    .line 52
    invoke-virtual {p0}, Lcom/rokid/phone/GalleryActivity;->getBinding()Landroidx/viewbinding/ViewBinding;

    move-result-object v0

    check-cast v0, Lcom/rokid/phone/databinding/ActivityGalleryBinding;

    iget-object v0, v0, Lcom/rokid/phone/databinding/ActivityGalleryBinding;->recyclerView:Landroidx/recyclerview/widget/RecyclerView;

    iget-object v1, p0, Lcom/rokid/phone/GalleryActivity;->adapter:Lcom/rokid/phone/adapter/MediaAdapter;

    if-nez v1, :cond_0

    const-string v1, "adapter"

    invoke-static {v1}, Lkotlin/jvm/internal/Intrinsics;->throwUninitializedPropertyAccessException(Ljava/lang/String;)V

    const/4 v1, 0x0

    :cond_0
    check-cast v1, Landroidx/recyclerview/widget/RecyclerView$Adapter;

    invoke-virtual {v0, v1}, Landroidx/recyclerview/widget/RecyclerView;->setAdapter(Landroidx/recyclerview/widget/RecyclerView$Adapter;)V

    .line 53
    invoke-virtual {p0}, Lcom/rokid/phone/GalleryActivity;->getBinding()Landroidx/viewbinding/ViewBinding;

    move-result-object v0

    check-cast v0, Lcom/rokid/phone/databinding/ActivityGalleryBinding;

    iget-object v0, v0, Lcom/rokid/phone/databinding/ActivityGalleryBinding;->btnBack:Landroid/widget/ImageButton;

    new-instance v1, Lcom/rokid/phone/GalleryActivity$$ExternalSyntheticLambda1;

    invoke-direct {v1, p0}, Lcom/rokid/phone/GalleryActivity$$ExternalSyntheticLambda1;-><init>(Lcom/rokid/phone/GalleryActivity;)V

    invoke-virtual {v0, v1}, Landroid/widget/ImageButton;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 54
    invoke-direct {p0}, Lcom/rokid/phone/GalleryActivity;->loadMedia()V

    .line 55
    return-void
.end method

.method protected onStart()V
    .locals 2

    .line 58
    invoke-super {p0}, Lcom/rokid/phone/base/BaseActivity;->onStart()V

    .line 59
    iget-boolean v0, p0, Lcom/rokid/phone/GalleryActivity;->listening:Z

    if-nez v0, :cond_2

    .line 60
    invoke-static {}, Lcom/rokid/security/phone/sdk/api/PSecuritySDK;->getMessageService()Lcom/rokid/security/phone/sdk/api/msg/api/AbsMessageService;

    move-result-object v0

    if-eqz v0, :cond_0

    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/api/msg/api/AbsMessageService;->getFileOperater()Lcom/rokid/security/phone/sdk/api/msg/api/IFileOperate;

    move-result-object v0

    if-eqz v0, :cond_0

    iget-object v1, p0, Lcom/rokid/phone/GalleryActivity;->fileListener:Lcom/rokid/phone/GalleryActivity$fileListener$1;

    check-cast v1, Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveV2Listener;

    invoke-interface {v0, v1}, Lcom/rokid/security/phone/sdk/api/msg/api/IFileOperate;->addFileReceiveV2Listener(Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveV2Listener;)V

    .line 61
    :cond_0
    invoke-static {}, Lcom/rokid/security/phone/sdk/api/PSecuritySDK;->getMessageService()Lcom/rokid/security/phone/sdk/api/msg/api/AbsMessageService;

    move-result-object v0

    if-eqz v0, :cond_1

    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/api/msg/api/AbsMessageService;->getBtFileOperater()Lcom/rokid/security/phone/sdk/api/msg/api/IFileOperate;

    move-result-object v0

    if-eqz v0, :cond_1

    iget-object v1, p0, Lcom/rokid/phone/GalleryActivity;->fileListener:Lcom/rokid/phone/GalleryActivity$fileListener$1;

    check-cast v1, Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveV2Listener;

    invoke-interface {v0, v1}, Lcom/rokid/security/phone/sdk/api/msg/api/IFileOperate;->addFileReceiveV2Listener(Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveV2Listener;)V

    .line 62
    :cond_1
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/rokid/phone/GalleryActivity;->listening:Z

    .line 64
    :cond_2
    invoke-direct {p0}, Lcom/rokid/phone/GalleryActivity;->loadMedia()V

    .line 65
    return-void
.end method

.method protected onStop()V
    .locals 2

    .line 68
    iget-boolean v0, p0, Lcom/rokid/phone/GalleryActivity;->listening:Z

    if-eqz v0, :cond_2

    .line 69
    invoke-static {}, Lcom/rokid/security/phone/sdk/api/PSecuritySDK;->getMessageService()Lcom/rokid/security/phone/sdk/api/msg/api/AbsMessageService;

    move-result-object v0

    if-eqz v0, :cond_0

    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/api/msg/api/AbsMessageService;->getFileOperater()Lcom/rokid/security/phone/sdk/api/msg/api/IFileOperate;

    move-result-object v0

    if-eqz v0, :cond_0

    iget-object v1, p0, Lcom/rokid/phone/GalleryActivity;->fileListener:Lcom/rokid/phone/GalleryActivity$fileListener$1;

    check-cast v1, Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveV2Listener;

    invoke-interface {v0, v1}, Lcom/rokid/security/phone/sdk/api/msg/api/IFileOperate;->removeFileReceiveV2Listener(Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveV2Listener;)V

    .line 70
    :cond_0
    invoke-static {}, Lcom/rokid/security/phone/sdk/api/PSecuritySDK;->getMessageService()Lcom/rokid/security/phone/sdk/api/msg/api/AbsMessageService;

    move-result-object v0

    if-eqz v0, :cond_1

    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/api/msg/api/AbsMessageService;->getBtFileOperater()Lcom/rokid/security/phone/sdk/api/msg/api/IFileOperate;

    move-result-object v0

    if-eqz v0, :cond_1

    iget-object v1, p0, Lcom/rokid/phone/GalleryActivity;->fileListener:Lcom/rokid/phone/GalleryActivity$fileListener$1;

    check-cast v1, Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveV2Listener;

    invoke-interface {v0, v1}, Lcom/rokid/security/phone/sdk/api/msg/api/IFileOperate;->removeFileReceiveV2Listener(Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveV2Listener;)V

    .line 71
    :cond_1
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/rokid/phone/GalleryActivity;->listening:Z

    .line 73
    :cond_2
    invoke-super {p0}, Lcom/rokid/phone/base/BaseActivity;->onStop()V

    .line 74
    return-void
.end method
