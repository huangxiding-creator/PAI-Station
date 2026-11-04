.class public final Lcom/rokid/phone/ai/AiVisionActivity;
.super Lcom/rokid/phone/base/BaseActivity;
.source "AiVisionActivity.kt"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/rokid/phone/ai/AiVisionActivity$PendingAction;
    }
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lcom/rokid/phone/base/BaseActivity<",
        "Lcom/rokid/phone/databinding/ActivityAiVisionBinding;",
        ">;"
    }
.end annotation

.annotation system Ldalvik/annotation/SourceDebugExtension;
    value = "SMAP\nAiVisionActivity.kt\nKotlin\n*S Kotlin\n*F\n+ 1 AiVisionActivity.kt\ncom/rokid/phone/ai/AiVisionActivity\n+ 2 _Collections.kt\nkotlin/collections/CollectionsKt___CollectionsKt\n+ 3 fake.kt\nkotlin/jvm/internal/FakeKt\n*L\n1#1,321:1\n774#2:322\n865#2,2:323\n1869#2,2:325\n1869#2,2:327\n774#2:329\n865#2,2:330\n774#2:332\n865#2,2:333\n774#2:335\n865#2,2:336\n1761#2,3:338\n774#2:341\n865#2,2:342\n1068#2:344\n2746#2,3:345\n295#2,2:348\n1#3:350\n*S KotlinDebug\n*F\n+ 1 AiVisionActivity.kt\ncom/rokid/phone/ai/AiVisionActivity\n*L\n124#1:322\n124#1:323,2\n127#1:325,2\n135#1:327,2\n137#1:329\n137#1:330,2\n139#1:332\n139#1:333,2\n149#1:335\n149#1:336,2\n156#1:338,3\n179#1:341\n179#1:342,2\n179#1:344\n181#1:345,3\n215#1:348,2\n*E\n"
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000s\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0003\n\u0002\u0018\u0002\n\u0002\u0010\u000e\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010!\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u000b\n\u0002\u0008\u0002\n\u0002\u0008\u0003\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0010\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0013\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0004*\u0001\u0018\u0018\u00002\u0008\u0012\u0004\u0012\u00020\u00020\u0001:\u00019B\u0007\u00a2\u0006\u0004\u0008\u0003\u0010\u0004J\u0008\u0010\u001c\u001a\u00020\u0002H\u0016J\u0012\u0010\u001d\u001a\u00020\u001e2\u0008\u0010\u001f\u001a\u0004\u0018\u00010 H\u0016J\u0008\u0010!\u001a\u00020\u001eH\u0014J\u0008\u0010\"\u001a\u00020\u001eH\u0014J\u0008\u0010#\u001a\u00020\u001eH\u0014J\u0008\u0010$\u001a\u00020\u001eH\u0002J\u0008\u0010%\u001a\u00020\u0015H\u0002J\u0010\u0010&\u001a\u00020\u001e2\u0006\u0010\'\u001a\u00020\u0008H\u0002J\u0008\u0010(\u001a\u00020\u001eH\u0002J\u0010\u0010)\u001a\u00020\u00072\u0006\u0010*\u001a\u00020\u0007H\u0002J\u0010\u0010+\u001a\u00020\u001e2\u0006\u0010,\u001a\u00020\u0007H\u0002J\n\u0010-\u001a\u0004\u0018\u00010\u0008H\u0002J\u0008\u0010.\u001a\u00020\u001eH\u0002J\u0008\u0010/\u001a\u00020\u001eH\u0002J\u0010\u00100\u001a\u00020\u001e2\u0006\u00101\u001a\u00020\u0015H\u0002J\u0018\u00102\u001a\u00020\u00152\u0006\u00103\u001a\u0002042\u0006\u00105\u001a\u000206H\u0002J\u0010\u00107\u001a\u00020\u001e2\u0006\u00108\u001a\u000206H\u0002R*\u0010\u0005\u001a\u001e\u0012\u0004\u0012\u00020\u0007\u0012\u0004\u0012\u00020\u00080\u0006j\u000e\u0012\u0004\u0012\u00020\u0007\u0012\u0004\u0012\u00020\u0008`\tX\u0082\u0004\u00a2\u0006\u0002\n\u0000R\u0014\u0010\n\u001a\u0008\u0012\u0004\u0012\u00020\u00080\u000bX\u0082\u0004\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u000c\u001a\u00020\rX\u0082.\u00a2\u0006\u0002\n\u0000R\u0010\u0010\u000e\u001a\u0004\u0018\u00010\u000fX\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0010\u001a\u00020\u0011X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u0010\u0010\u0012\u001a\u0004\u0018\u00010\u0013X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0014\u001a\u00020\u0015X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u0010\u0010\u0016\u001a\u0004\u0018\u00010\u0007X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u0010\u0010\u0017\u001a\u00020\u0018X\u0082\u0004\u00a2\u0006\u0004\n\u0002\u0010\u0019R\u0014\u0010\u001a\u001a\u0008\u0012\u0004\u0012\u00020\u00070\u001bX\u0082\u0004\u00a2\u0006\u0002\n\u0000\u00a8\u0006:"
    }
    d2 = {
        "Lcom/rokid/phone/ai/AiVisionActivity;",
        "Lcom/rokid/phone/base/BaseActivity;",
        "Lcom/rokid/phone/databinding/ActivityAiVisionBinding;",
        "<init>",
        "()V",
        "recordMap",
        "Ljava/util/LinkedHashMap;",
        "",
        "Lcom/rokid/phone/ai/AiVisionRecord;",
        "Lkotlin/collections/LinkedHashMap;",
        "visibleRecords",
        "",
        "adapter",
        "Lcom/rokid/phone/adapter/AiVisionAdapter;",
        "currentReport",
        "Lcom/rokid/phone/ai/AiVisionPdfGenerator$Result;",
        "pendingAction",
        "Lcom/rokid/phone/ai/AiVisionActivity$PendingAction;",
        "reportJob",
        "Lkotlinx/coroutines/Job;",
        "receiverRegistered",
        "",
        "selectedQuestionId",
        "recordsUpdatedReceiver",
        "com/rokid/phone/ai/AiVisionActivity$recordsUpdatedReceiver$1",
        "Lcom/rokid/phone/ai/AiVisionActivity$recordsUpdatedReceiver$1;",
        "createReportDocument",
        "Landroidx/activity/result/ActivityResultLauncher;",
        "initViewBinding",
        "onInit",
        "",
        "savedInstanceState",
        "Landroid/os/Bundle;",
        "onResume",
        "onPause",
        "onDestroy",
        "loadStoredRecords",
        "compactSupersededCommercialResults",
        "updateGeneratedReportMetadata",
        "record",
        "publishRecords",
        "questionForDisplay",
        "question",
        "selectRecord",
        "questionId",
        "selectedRecord",
        "updateReportButtons",
        "invalidateReport",
        "generateReport",
        "saveAndOpen",
        "copyReportToUri",
        "source",
        "Ljava/io/File;",
        "target",
        "Landroid/net/Uri;",
        "openReport",
        "uri",
        "PendingAction",
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
.field private adapter:Lcom/rokid/phone/adapter/AiVisionAdapter;

.field private final createReportDocument:Landroidx/activity/result/ActivityResultLauncher;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Landroidx/activity/result/ActivityResultLauncher<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field private currentReport:Lcom/rokid/phone/ai/AiVisionPdfGenerator$Result;

.field private pendingAction:Lcom/rokid/phone/ai/AiVisionActivity$PendingAction;

.field private receiverRegistered:Z

.field private final recordMap:Ljava/util/LinkedHashMap;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/LinkedHashMap<",
            "Ljava/lang/String;",
            "Lcom/rokid/phone/ai/AiVisionRecord;",
            ">;"
        }
    .end annotation
.end field

.field private final recordsUpdatedReceiver:Lcom/rokid/phone/ai/AiVisionActivity$recordsUpdatedReceiver$1;

.field private reportJob:Lkotlinx/coroutines/Job;

.field private selectedQuestionId:Ljava/lang/String;

.field private final visibleRecords:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lcom/rokid/phone/ai/AiVisionRecord;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method public static synthetic $r8$lambda$YhRvr7Pdx0iaV9IedZoSOTwb7DE(Lcom/rokid/phone/ai/AiVisionActivity;Landroid/net/Uri;)V
    .locals 0

    invoke-static {p0, p1}, Lcom/rokid/phone/ai/AiVisionActivity;->createReportDocument$lambda$0(Lcom/rokid/phone/ai/AiVisionActivity;Landroid/net/Uri;)V

    return-void
.end method

.method public static synthetic $r8$lambda$_Iei_PhQUCtmEgBbP2F2U-QHz4k(Lcom/rokid/phone/ai/AiVisionActivity;Landroid/view/View;)V
    .locals 0

    invoke-static {p0, p1}, Lcom/rokid/phone/ai/AiVisionActivity;->onInit$lambda$2(Lcom/rokid/phone/ai/AiVisionActivity;Landroid/view/View;)V

    return-void
.end method

.method public static synthetic $r8$lambda$hHcRTtqy8M1XNpKPIMvPdD9XWi8(Lcom/rokid/phone/ai/AiVisionActivity;Ljava/lang/String;)Lkotlin/Unit;
    .locals 0

    invoke-static {p0, p1}, Lcom/rokid/phone/ai/AiVisionActivity;->onInit$lambda$1(Lcom/rokid/phone/ai/AiVisionActivity;Ljava/lang/String;)Lkotlin/Unit;

    move-result-object p0

    return-object p0
.end method

.method public static synthetic $r8$lambda$hqPkRiUT6DJQeLz6UiaX5YT1j84(Lcom/rokid/phone/ai/AiVisionActivity;Landroid/view/View;)V
    .locals 0

    invoke-static {p0, p1}, Lcom/rokid/phone/ai/AiVisionActivity;->onInit$lambda$4(Lcom/rokid/phone/ai/AiVisionActivity;Landroid/view/View;)V

    return-void
.end method

.method public static synthetic $r8$lambda$slmESewfGrsO00UeopIo_AxEFW8(Lcom/rokid/phone/ai/AiVisionActivity;Landroid/view/View;)V
    .locals 0

    invoke-static {p0, p1}, Lcom/rokid/phone/ai/AiVisionActivity;->onInit$lambda$3(Lcom/rokid/phone/ai/AiVisionActivity;Landroid/view/View;)V

    return-void
.end method

.method public constructor <init>()V
    .locals 2

    .line 31
    invoke-direct {p0}, Lcom/rokid/phone/base/BaseActivity;-><init>()V

    .line 37
    new-instance v0, Ljava/util/LinkedHashMap;

    invoke-direct {v0}, Ljava/util/LinkedHashMap;-><init>()V

    iput-object v0, p0, Lcom/rokid/phone/ai/AiVisionActivity;->recordMap:Ljava/util/LinkedHashMap;

    .line 38
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    check-cast v0, Ljava/util/List;

    iput-object v0, p0, Lcom/rokid/phone/ai/AiVisionActivity;->visibleRecords:Ljava/util/List;

    .line 41
    sget-object v0, Lcom/rokid/phone/ai/AiVisionActivity$PendingAction$SaveOnly;->INSTANCE:Lcom/rokid/phone/ai/AiVisionActivity$PendingAction$SaveOnly;

    check-cast v0, Lcom/rokid/phone/ai/AiVisionActivity$PendingAction;

    iput-object v0, p0, Lcom/rokid/phone/ai/AiVisionActivity;->pendingAction:Lcom/rokid/phone/ai/AiVisionActivity$PendingAction;

    .line 46
    new-instance v0, Lcom/rokid/phone/ai/AiVisionActivity$recordsUpdatedReceiver$1;

    invoke-direct {v0, p0}, Lcom/rokid/phone/ai/AiVisionActivity$recordsUpdatedReceiver$1;-><init>(Lcom/rokid/phone/ai/AiVisionActivity;)V

    iput-object v0, p0, Lcom/rokid/phone/ai/AiVisionActivity;->recordsUpdatedReceiver:Lcom/rokid/phone/ai/AiVisionActivity$recordsUpdatedReceiver$1;

    .line 52
    nop

    .line 53
    new-instance v0, Landroidx/activity/result/contract/ActivityResultContracts$CreateDocument;

    const-string v1, "application/pdf"

    invoke-direct {v0, v1}, Landroidx/activity/result/contract/ActivityResultContracts$CreateDocument;-><init>(Ljava/lang/String;)V

    check-cast v0, Landroidx/activity/result/contract/ActivityResultContract;

    .line 54
    nop

    .line 52
    new-instance v1, Lcom/rokid/phone/ai/AiVisionActivity$$ExternalSyntheticLambda4;

    invoke-direct {v1, p0}, Lcom/rokid/phone/ai/AiVisionActivity$$ExternalSyntheticLambda4;-><init>(Lcom/rokid/phone/ai/AiVisionActivity;)V

    invoke-virtual {p0, v0, v1}, Lcom/rokid/phone/ai/AiVisionActivity;->registerForActivityResult(Landroidx/activity/result/contract/ActivityResultContract;Landroidx/activity/result/ActivityResultCallback;)Landroidx/activity/result/ActivityResultLauncher;

    move-result-object v0

    iput-object v0, p0, Lcom/rokid/phone/ai/AiVisionActivity;->createReportDocument:Landroidx/activity/result/ActivityResultLauncher;

    .line 31
    return-void
.end method

.method public static final synthetic access$copyReportToUri(Lcom/rokid/phone/ai/AiVisionActivity;Ljava/io/File;Landroid/net/Uri;)Z
    .locals 1
    .param p0, "$this"    # Lcom/rokid/phone/ai/AiVisionActivity;
    .param p1, "source"    # Ljava/io/File;
    .param p2, "target"    # Landroid/net/Uri;

    .line 31
    invoke-direct {p0, p1, p2}, Lcom/rokid/phone/ai/AiVisionActivity;->copyReportToUri(Ljava/io/File;Landroid/net/Uri;)Z

    move-result v0

    return v0
.end method

.method public static final synthetic access$getBinding(Lcom/rokid/phone/ai/AiVisionActivity;)Lcom/rokid/phone/databinding/ActivityAiVisionBinding;
    .locals 1
    .param p0, "$this"    # Lcom/rokid/phone/ai/AiVisionActivity;

    .line 31
    invoke-virtual {p0}, Lcom/rokid/phone/ai/AiVisionActivity;->getBinding()Landroidx/viewbinding/ViewBinding;

    move-result-object v0

    check-cast v0, Lcom/rokid/phone/databinding/ActivityAiVisionBinding;

    return-object v0
.end method

.method public static final synthetic access$getCreateReportDocument$p(Lcom/rokid/phone/ai/AiVisionActivity;)Landroidx/activity/result/ActivityResultLauncher;
    .locals 1
    .param p0, "$this"    # Lcom/rokid/phone/ai/AiVisionActivity;

    .line 31
    iget-object v0, p0, Lcom/rokid/phone/ai/AiVisionActivity;->createReportDocument:Landroidx/activity/result/ActivityResultLauncher;

    return-object v0
.end method

.method public static final synthetic access$getCurrentReport$p(Lcom/rokid/phone/ai/AiVisionActivity;)Lcom/rokid/phone/ai/AiVisionPdfGenerator$Result;
    .locals 1
    .param p0, "$this"    # Lcom/rokid/phone/ai/AiVisionActivity;

    .line 31
    iget-object v0, p0, Lcom/rokid/phone/ai/AiVisionActivity;->currentReport:Lcom/rokid/phone/ai/AiVisionPdfGenerator$Result;

    return-object v0
.end method

.method public static final synthetic access$getPendingAction$p(Lcom/rokid/phone/ai/AiVisionActivity;)Lcom/rokid/phone/ai/AiVisionActivity$PendingAction;
    .locals 1
    .param p0, "$this"    # Lcom/rokid/phone/ai/AiVisionActivity;

    .line 31
    iget-object v0, p0, Lcom/rokid/phone/ai/AiVisionActivity;->pendingAction:Lcom/rokid/phone/ai/AiVisionActivity$PendingAction;

    return-object v0
.end method

.method public static final synthetic access$loadStoredRecords(Lcom/rokid/phone/ai/AiVisionActivity;)V
    .locals 0
    .param p0, "$this"    # Lcom/rokid/phone/ai/AiVisionActivity;

    .line 31
    invoke-direct {p0}, Lcom/rokid/phone/ai/AiVisionActivity;->loadStoredRecords()V

    return-void
.end method

.method public static final synthetic access$openReport(Lcom/rokid/phone/ai/AiVisionActivity;Landroid/net/Uri;)V
    .locals 0
    .param p0, "$this"    # Lcom/rokid/phone/ai/AiVisionActivity;
    .param p1, "uri"    # Landroid/net/Uri;

    .line 31
    invoke-direct {p0, p1}, Lcom/rokid/phone/ai/AiVisionActivity;->openReport(Landroid/net/Uri;)V

    return-void
.end method

.method public static final synthetic access$selectedRecord(Lcom/rokid/phone/ai/AiVisionActivity;)Lcom/rokid/phone/ai/AiVisionRecord;
    .locals 1
    .param p0, "$this"    # Lcom/rokid/phone/ai/AiVisionActivity;

    .line 31
    invoke-direct {p0}, Lcom/rokid/phone/ai/AiVisionActivity;->selectedRecord()Lcom/rokid/phone/ai/AiVisionRecord;

    move-result-object v0

    return-object v0
.end method

.method public static final synthetic access$setCurrentReport$p(Lcom/rokid/phone/ai/AiVisionActivity;Lcom/rokid/phone/ai/AiVisionPdfGenerator$Result;)V
    .locals 0
    .param p0, "$this"    # Lcom/rokid/phone/ai/AiVisionActivity;
    .param p1, "<set-?>"    # Lcom/rokid/phone/ai/AiVisionPdfGenerator$Result;

    .line 31
    iput-object p1, p0, Lcom/rokid/phone/ai/AiVisionActivity;->currentReport:Lcom/rokid/phone/ai/AiVisionPdfGenerator$Result;

    return-void
.end method

.method private final compactSupersededCommercialResults()Z
    .locals 12

    .line 149
    iget-object v0, p0, Lcom/rokid/phone/ai/AiVisionActivity;->recordMap:Ljava/util/LinkedHashMap;

    invoke-virtual {v0}, Ljava/util/LinkedHashMap;->values()Ljava/util/Collection;

    move-result-object v0

    const-string v1, "<get-values>(...)"

    invoke-static {v0, v1}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    check-cast v0, Ljava/lang/Iterable;

    .local v0, "$this$filter$iv":Ljava/lang/Iterable;
    sget-object v1, Lcom/rokid/phone/ai/AiVisionAnswerPolicy;->INSTANCE:Lcom/rokid/phone/ai/AiVisionAnswerPolicy;

    const/4 v2, 0x0

    .line 335
    .local v2, "$i$f$filter":I
    new-instance v3, Ljava/util/ArrayList;

    invoke-direct {v3}, Ljava/util/ArrayList;-><init>()V

    check-cast v3, Ljava/util/Collection;

    .local v3, "destination$iv$iv":Ljava/util/Collection;
    move-object v4, v0

    .local v4, "$this$filterTo$iv$iv":Ljava/lang/Iterable;
    const/4 v5, 0x0

    .line 336
    .local v5, "$i$f$filterTo":I
    invoke-interface {v4}, Ljava/lang/Iterable;->iterator()Ljava/util/Iterator;

    move-result-object v6

    :cond_0
    :goto_0
    invoke-interface {v6}, Ljava/util/Iterator;->hasNext()Z

    move-result v7

    if-eqz v7, :cond_1

    invoke-interface {v6}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v7

    .local v7, "element$iv$iv":Ljava/lang/Object;
    move-object v8, v7

    check-cast v8, Lcom/rokid/phone/ai/AiVisionRecord;

    .local v8, "p0":Lcom/rokid/phone/ai/AiVisionRecord;
    const/4 v9, 0x0

    .line 149
    .local v9, "$i$a$-filter-AiVisionActivity$compactSupersededCommercialResults$inspections$1":I
    invoke-virtual {v1, v8}, Lcom/rokid/phone/ai/AiVisionAnswerPolicy;->isStructuredInspection(Lcom/rokid/phone/ai/AiVisionRecord;)Z

    move-result v8

    .line 336
    .end local v8    # "p0":Lcom/rokid/phone/ai/AiVisionRecord;
    .end local v9    # "$i$a$-filter-AiVisionActivity$compactSupersededCommercialResults$inspections$1":I
    if-eqz v8, :cond_0

    invoke-interface {v3, v7}, Ljava/util/Collection;->add(Ljava/lang/Object;)Z

    goto :goto_0

    .line 337
    .end local v7    # "element$iv$iv":Ljava/lang/Object;
    :cond_1
    nop

    .end local v3    # "destination$iv$iv":Ljava/util/Collection;
    .end local v4    # "$this$filterTo$iv$iv":Ljava/lang/Iterable;
    .end local v5    # "$i$f$filterTo":I
    move-object v1, v3

    check-cast v1, Ljava/util/List;

    .line 335
    nop

    .line 149
    .end local v0    # "$this$filter$iv":Ljava/lang/Iterable;
    .end local v2    # "$i$f$filter":I
    move-object v0, v1

    .line 150
    .local v0, "inspections":Ljava/util/List;
    invoke-interface {v0}, Ljava/util/List;->isEmpty()Z

    move-result v1

    const/4 v2, 0x0

    if-eqz v1, :cond_2

    return v2

    .line 152
    :cond_2
    const/4 v1, 0x0

    .line 153
    .local v1, "changed":Z
    iget-object v3, p0, Lcom/rokid/phone/ai/AiVisionActivity;->recordMap:Ljava/util/LinkedHashMap;

    invoke-virtual {v3}, Ljava/util/LinkedHashMap;->entrySet()Ljava/util/Set;

    move-result-object v3

    invoke-interface {v3}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v3

    .line 154
    .local v3, "iterator":Ljava/util/Iterator;
    :cond_3
    :goto_1
    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z

    move-result v4

    if-eqz v4, :cond_7

    .line 155
    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Ljava/util/Map$Entry;

    invoke-interface {v4}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v4

    const-string v5, "<get-value>(...)"

    invoke-static {v4, v5}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    check-cast v4, Lcom/rokid/phone/ai/AiVisionRecord;

    .line 156
    .local v4, "record":Lcom/rokid/phone/ai/AiVisionRecord;
    move-object v5, v0

    check-cast v5, Ljava/lang/Iterable;

    .local v5, "$this$any$iv":Ljava/lang/Iterable;
    const/4 v6, 0x0

    .line 338
    .local v6, "$i$f$any":I
    instance-of v7, v5, Ljava/util/Collection;

    if-eqz v7, :cond_4

    move-object v7, v5

    check-cast v7, Ljava/util/Collection;

    invoke-interface {v7}, Ljava/util/Collection;->isEmpty()Z

    move-result v7

    if-eqz v7, :cond_4

    move v7, v2

    goto :goto_2

    .line 339
    :cond_4
    invoke-interface {v5}, Ljava/lang/Iterable;->iterator()Ljava/util/Iterator;

    move-result-object v7

    :cond_5
    invoke-interface {v7}, Ljava/util/Iterator;->hasNext()Z

    move-result v8

    if-eqz v8, :cond_6

    invoke-interface {v7}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v8

    .local v8, "element$iv":Ljava/lang/Object;
    move-object v9, v8

    check-cast v9, Lcom/rokid/phone/ai/AiVisionRecord;

    .local v9, "it":Lcom/rokid/phone/ai/AiVisionRecord;
    const/4 v10, 0x0

    .line 156
    .local v10, "$i$a$-any-AiVisionActivity$compactSupersededCommercialResults$1":I
    sget-object v11, Lcom/rokid/phone/ai/AiVisionAnswerPolicy;->INSTANCE:Lcom/rokid/phone/ai/AiVisionAnswerPolicy;

    invoke-virtual {v11, v4, v9}, Lcom/rokid/phone/ai/AiVisionAnswerPolicy;->supersedes(Lcom/rokid/phone/ai/AiVisionRecord;Lcom/rokid/phone/ai/AiVisionRecord;)Z

    move-result v9

    .line 339
    .end local v9    # "it":Lcom/rokid/phone/ai/AiVisionRecord;
    .end local v10    # "$i$a$-any-AiVisionActivity$compactSupersededCommercialResults$1":I
    if-eqz v9, :cond_5

    const/4 v7, 0x1

    goto :goto_2

    .line 340
    .end local v8    # "element$iv":Ljava/lang/Object;
    :cond_6
    move v7, v2

    .line 156
    .end local v5    # "$this$any$iv":Ljava/lang/Iterable;
    .end local v6    # "$i$f$any":I
    :goto_2
    if-eqz v7, :cond_3

    .line 157
    invoke-interface {v3}, Ljava/util/Iterator;->remove()V

    .line 158
    const/4 v1, 0x1

    .end local v4    # "record":Lcom/rokid/phone/ai/AiVisionRecord;
    goto :goto_1

    .line 161
    :cond_7
    return v1
.end method

.method private final copyReportToUri(Ljava/io/File;Landroid/net/Uri;)Z
    .locals 12
    .param p1, "source"    # Ljava/io/File;
    .param p2, "target"    # Landroid/net/Uri;

    .line 296
    const/4 v0, 0x0

    :try_start_0
    sget-object v1, Lkotlin/Result;->Companion:Lkotlin/Result$Companion;

    move-object v1, p0

    check-cast v1, Lcom/rokid/phone/ai/AiVisionActivity;

    .local v1, "$this$copyReportToUri_u24lambda_u2417":Lcom/rokid/phone/ai/AiVisionActivity;
    const/4 v2, 0x0

    .line 297
    .local v2, "$i$a$-runCatching-AiVisionActivity$copyReportToUri$1":I
    invoke-virtual {v1}, Lcom/rokid/phone/ai/AiVisionActivity;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object v3

    invoke-virtual {v3, p2}, Landroid/content/ContentResolver;->openOutputStream(Landroid/net/Uri;)Ljava/io/OutputStream;

    move-result-object v3

    if-eqz v3, :cond_0

    check-cast v3, Ljava/io/Closeable;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_4

    :try_start_1
    move-object v4, v3

    check-cast v4, Ljava/io/OutputStream;

    .local v4, "output":Ljava/io/OutputStream;
    const/4 v5, 0x0

    .line 298
    .local v5, "$i$a$-use-AiVisionActivity$copyReportToUri$1$1":I
    new-instance v6, Ljava/io/FileInputStream;

    invoke-direct {v6, p1}, Ljava/io/FileInputStream;-><init>(Ljava/io/File;)V

    check-cast v6, Ljava/io/Closeable;
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_2

    :try_start_2
    move-object v7, v6

    check-cast v7, Ljava/io/FileInputStream;

    .line 350
    .local v7, "input":Ljava/io/FileInputStream;
    const/4 v8, 0x0

    .line 298
    .local v8, "$i$a$-use-AiVisionActivity$copyReportToUri$1$1$1":I
    move-object v9, v7

    check-cast v9, Ljava/io/InputStream;

    const/4 v10, 0x2

    const/4 v11, 0x0

    invoke-static {v9, v4, v0, v10, v11}, Lkotlin/io/ByteStreamsKt;->copyTo$default(Ljava/io/InputStream;Ljava/io/OutputStream;IILjava/lang/Object;)J
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .end local v7    # "input":Ljava/io/FileInputStream;
    .end local v8    # "$i$a$-use-AiVisionActivity$copyReportToUri$1$1$1":I
    :try_start_3
    invoke-static {v6, v11}, Lkotlin/io/CloseableKt;->closeFinally(Ljava/io/Closeable;Ljava/lang/Throwable;)V
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_2

    .line 297
    .end local v4    # "output":Ljava/io/OutputStream;
    .end local v5    # "$i$a$-use-AiVisionActivity$copyReportToUri$1$1":I
    :try_start_4
    invoke-static {v3, v11}, Lkotlin/io/CloseableKt;->closeFinally(Ljava/io/Closeable;Ljava/lang/Throwable;)V

    .line 300
    const/4 v1, 0x1

    .end local v1    # "$this$copyReportToUri_u24lambda_u2417":Lcom/rokid/phone/ai/AiVisionActivity;
    .end local v2    # "$i$a$-runCatching-AiVisionActivity$copyReportToUri$1":I
    invoke-static {v1}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v1

    .line 296
    invoke-static {v1}, Lkotlin/Result;->constructor-impl(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_4

    goto :goto_0

    .line 298
    .restart local v1    # "$this$copyReportToUri_u24lambda_u2417":Lcom/rokid/phone/ai/AiVisionActivity;
    .restart local v2    # "$i$a$-runCatching-AiVisionActivity$copyReportToUri$1":I
    .restart local v4    # "output":Ljava/io/OutputStream;
    .restart local v5    # "$i$a$-use-AiVisionActivity$copyReportToUri$1$1":I
    :catchall_0
    move-exception v7

    .end local v1    # "$this$copyReportToUri_u24lambda_u2417":Lcom/rokid/phone/ai/AiVisionActivity;
    .end local v2    # "$i$a$-runCatching-AiVisionActivity$copyReportToUri$1":I
    .end local v4    # "output":Ljava/io/OutputStream;
    .end local v5    # "$i$a$-use-AiVisionActivity$copyReportToUri$1$1":I
    .end local p1    # "source":Ljava/io/File;
    .end local p2    # "target":Landroid/net/Uri;
    :try_start_5
    throw v7
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_1

    .restart local v1    # "$this$copyReportToUri_u24lambda_u2417":Lcom/rokid/phone/ai/AiVisionActivity;
    .restart local v2    # "$i$a$-runCatching-AiVisionActivity$copyReportToUri$1":I
    .restart local v4    # "output":Ljava/io/OutputStream;
    .restart local v5    # "$i$a$-use-AiVisionActivity$copyReportToUri$1$1":I
    .restart local p1    # "source":Ljava/io/File;
    .restart local p2    # "target":Landroid/net/Uri;
    :catchall_1
    move-exception v8

    :try_start_6
    invoke-static {v6, v7}, Lkotlin/io/CloseableKt;->closeFinally(Ljava/io/Closeable;Ljava/lang/Throwable;)V

    .end local v1    # "$this$copyReportToUri_u24lambda_u2417":Lcom/rokid/phone/ai/AiVisionActivity;
    .end local v2    # "$i$a$-runCatching-AiVisionActivity$copyReportToUri$1":I
    .end local p1    # "source":Ljava/io/File;
    .end local p2    # "target":Landroid/net/Uri;
    throw v8
    :try_end_6
    .catchall {:try_start_6 .. :try_end_6} :catchall_2

    .line 297
    .end local v4    # "output":Ljava/io/OutputStream;
    .end local v5    # "$i$a$-use-AiVisionActivity$copyReportToUri$1$1":I
    .restart local v1    # "$this$copyReportToUri_u24lambda_u2417":Lcom/rokid/phone/ai/AiVisionActivity;
    .restart local v2    # "$i$a$-runCatching-AiVisionActivity$copyReportToUri$1":I
    .restart local p1    # "source":Ljava/io/File;
    .restart local p2    # "target":Landroid/net/Uri;
    :catchall_2
    move-exception v4

    .end local v1    # "$this$copyReportToUri_u24lambda_u2417":Lcom/rokid/phone/ai/AiVisionActivity;
    .end local v2    # "$i$a$-runCatching-AiVisionActivity$copyReportToUri$1":I
    .end local p1    # "source":Ljava/io/File;
    .end local p2    # "target":Landroid/net/Uri;
    :try_start_7
    throw v4
    :try_end_7
    .catchall {:try_start_7 .. :try_end_7} :catchall_3

    .restart local v1    # "$this$copyReportToUri_u24lambda_u2417":Lcom/rokid/phone/ai/AiVisionActivity;
    .restart local v2    # "$i$a$-runCatching-AiVisionActivity$copyReportToUri$1":I
    .restart local p1    # "source":Ljava/io/File;
    .restart local p2    # "target":Landroid/net/Uri;
    :catchall_3
    move-exception v5

    :try_start_8
    invoke-static {v3, v4}, Lkotlin/io/CloseableKt;->closeFinally(Ljava/io/Closeable;Ljava/lang/Throwable;)V

    .end local p1    # "source":Ljava/io/File;
    .end local p2    # "target":Landroid/net/Uri;
    throw v5
    :try_end_8
    .catchall {:try_start_8 .. :try_end_8} :catchall_4

    .line 299
    .restart local p1    # "source":Ljava/io/File;
    .restart local p2    # "target":Landroid/net/Uri;
    :cond_0
    return v0

    .line 296
    .end local v1    # "$this$copyReportToUri_u24lambda_u2417":Lcom/rokid/phone/ai/AiVisionActivity;
    .end local v2    # "$i$a$-runCatching-AiVisionActivity$copyReportToUri$1":I
    :catchall_4
    move-exception v1

    sget-object v2, Lkotlin/Result;->Companion:Lkotlin/Result$Companion;

    invoke-static {v1}, Lkotlin/ResultKt;->createFailure(Ljava/lang/Throwable;)Ljava/lang/Object;

    move-result-object v1

    invoke-static {v1}, Lkotlin/Result;->constructor-impl(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    .line 301
    :goto_0
    invoke-static {v0}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v0

    invoke-static {v1}, Lkotlin/Result;->isFailure-impl(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_1

    move-object v1, v0

    :cond_1
    check-cast v1, Ljava/lang/Boolean;

    invoke-virtual {v1}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v0

    .line 296
    return v0
.end method

.method private static final createReportDocument$lambda$0(Lcom/rokid/phone/ai/AiVisionActivity;Landroid/net/Uri;)V
    .locals 8
    .param p0, "this$0"    # Lcom/rokid/phone/ai/AiVisionActivity;
    .param p1, "uri"    # Landroid/net/Uri;

    .line 55
    iget-object v0, p0, Lcom/rokid/phone/ai/AiVisionActivity;->currentReport:Lcom/rokid/phone/ai/AiVisionPdfGenerator$Result;

    .line 56
    .local v0, "report":Lcom/rokid/phone/ai/AiVisionPdfGenerator$Result;
    if-eqz p1, :cond_1

    if-nez v0, :cond_0

    goto :goto_0

    .line 57
    :cond_0
    move-object v1, p0

    check-cast v1, Landroidx/lifecycle/LifecycleOwner;

    invoke-static {v1}, Landroidx/lifecycle/LifecycleOwnerKt;->getLifecycleScope(Landroidx/lifecycle/LifecycleOwner;)Landroidx/lifecycle/LifecycleCoroutineScope;

    move-result-object v1

    move-object v2, v1

    check-cast v2, Lkotlinx/coroutines/CoroutineScope;

    new-instance v1, Lcom/rokid/phone/ai/AiVisionActivity$createReportDocument$1$1;

    const/4 v3, 0x0

    invoke-direct {v1, p0, p1, v0, v3}, Lcom/rokid/phone/ai/AiVisionActivity$createReportDocument$1$1;-><init>(Lcom/rokid/phone/ai/AiVisionActivity;Landroid/net/Uri;Lcom/rokid/phone/ai/AiVisionPdfGenerator$Result;Lkotlin/coroutines/Continuation;)V

    move-object v5, v1

    check-cast v5, Lkotlin/jvm/functions/Function2;

    const/4 v6, 0x3

    const/4 v7, 0x0

    const/4 v4, 0x0

    invoke-static/range {v2 .. v7}, Lkotlinx/coroutines/BuildersKt;->launch$default(Lkotlinx/coroutines/CoroutineScope;Lkotlin/coroutines/CoroutineContext;Lkotlinx/coroutines/CoroutineStart;Lkotlin/jvm/functions/Function2;ILjava/lang/Object;)Lkotlinx/coroutines/Job;

    .line 78
    return-void

    .line 56
    :cond_1
    :goto_0
    return-void
.end method

.method private final generateReport(Z)V
    .locals 11
    .param p1, "saveAndOpen"    # Z

    .line 235
    invoke-direct {p0}, Lcom/rokid/phone/ai/AiVisionActivity;->selectedRecord()Lcom/rokid/phone/ai/AiVisionRecord;

    move-result-object v0

    .line 236
    .local v0, "selected":Lcom/rokid/phone/ai/AiVisionRecord;
    const/4 v1, 0x0

    const/4 v2, 0x1

    if-nez v0, :cond_0

    .line 238
    move-object v3, p0

    check-cast v3, Landroid/content/Context;

    .line 239
    sget v4, Lcom/rokid/phone/R$string;->demo_ai_vision_select_record:I

    new-array v1, v1, [Ljava/lang/Object;

    invoke-static {v4, v1}, Lcom/rokid/phone/utils/DemoStringsKt;->demoString(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    check-cast v1, Ljava/lang/CharSequence;

    .line 240
    nop

    .line 237
    invoke-static {v3, v1, v2}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object v1

    .line 241
    invoke-virtual {v1}, Landroid/widget/Toast;->show()V

    .line 242
    return-void

    .line 244
    :cond_0
    sget-object v3, Lcom/rokid/phone/ai/AiVisionAnswerPolicy;->INSTANCE:Lcom/rokid/phone/ai/AiVisionAnswerPolicy;

    invoke-virtual {v3, v0}, Lcom/rokid/phone/ai/AiVisionAnswerPolicy;->isReportReady(Lcom/rokid/phone/ai/AiVisionRecord;)Z

    move-result v3

    if-nez v3, :cond_1

    .line 246
    move-object v3, p0

    check-cast v3, Landroid/content/Context;

    .line 247
    sget v4, Lcom/rokid/phone/R$string;->demo_ai_vision_report_empty:I

    new-array v1, v1, [Ljava/lang/Object;

    invoke-static {v4, v1}, Lcom/rokid/phone/utils/DemoStringsKt;->demoString(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    check-cast v1, Ljava/lang/CharSequence;

    .line 248
    nop

    .line 245
    invoke-static {v3, v1, v2}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object v1

    .line 249
    invoke-virtual {v1}, Landroid/widget/Toast;->show()V

    .line 250
    return-void

    .line 252
    :cond_1
    invoke-static {v0}, Lkotlin/collections/CollectionsKt;->listOf(Ljava/lang/Object;)Ljava/util/List;

    move-result-object v1

    .line 253
    .local v1, "records":Ljava/util/List;
    iget-object v3, p0, Lcom/rokid/phone/ai/AiVisionActivity;->reportJob:Lkotlinx/coroutines/Job;

    const/4 v4, 0x0

    if-eqz v3, :cond_2

    invoke-static {v3, v4, v2, v4}, Lkotlinx/coroutines/Job$DefaultImpls;->cancel$default(Lkotlinx/coroutines/Job;Ljava/util/concurrent/CancellationException;ILjava/lang/Object;)V

    .line 254
    :cond_2
    if-eqz p1, :cond_3

    sget-object v2, Lcom/rokid/phone/ai/AiVisionActivity$PendingAction$SaveAndOpen;->INSTANCE:Lcom/rokid/phone/ai/AiVisionActivity$PendingAction$SaveAndOpen;

    goto :goto_0

    :cond_3
    sget-object v2, Lcom/rokid/phone/ai/AiVisionActivity$PendingAction$SaveOnly;->INSTANCE:Lcom/rokid/phone/ai/AiVisionActivity$PendingAction$SaveOnly;

    :goto_0
    check-cast v2, Lcom/rokid/phone/ai/AiVisionActivity$PendingAction;

    iput-object v2, p0, Lcom/rokid/phone/ai/AiVisionActivity;->pendingAction:Lcom/rokid/phone/ai/AiVisionActivity$PendingAction;

    .line 255
    move-object v2, p0

    check-cast v2, Landroidx/lifecycle/LifecycleOwner;

    invoke-static {v2}, Landroidx/lifecycle/LifecycleOwnerKt;->getLifecycleScope(Landroidx/lifecycle/LifecycleOwner;)Landroidx/lifecycle/LifecycleCoroutineScope;

    move-result-object v2

    move-object v5, v2

    check-cast v5, Lkotlinx/coroutines/CoroutineScope;

    new-instance v2, Lcom/rokid/phone/ai/AiVisionActivity$generateReport$1;

    invoke-direct {v2, p0, v1, p1, v4}, Lcom/rokid/phone/ai/AiVisionActivity$generateReport$1;-><init>(Lcom/rokid/phone/ai/AiVisionActivity;Ljava/util/List;ZLkotlin/coroutines/Continuation;)V

    move-object v8, v2

    check-cast v8, Lkotlin/jvm/functions/Function2;

    const/4 v9, 0x3

    const/4 v10, 0x0

    const/4 v6, 0x0

    const/4 v7, 0x0

    invoke-static/range {v5 .. v10}, Lkotlinx/coroutines/BuildersKt;->launch$default(Lkotlinx/coroutines/CoroutineScope;Lkotlin/coroutines/CoroutineContext;Lkotlinx/coroutines/CoroutineStart;Lkotlin/jvm/functions/Function2;ILjava/lang/Object;)Lkotlinx/coroutines/Job;

    move-result-object v2

    iput-object v2, p0, Lcom/rokid/phone/ai/AiVisionActivity;->reportJob:Lkotlinx/coroutines/Job;

    .line 293
    return-void
.end method

.method private final invalidateReport()V
    .locals 3

    .line 228
    iget-object v0, p0, Lcom/rokid/phone/ai/AiVisionActivity;->reportJob:Lkotlinx/coroutines/Job;

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    const/4 v2, 0x1

    invoke-static {v0, v1, v2, v1}, Lkotlinx/coroutines/Job$DefaultImpls;->cancel$default(Lkotlinx/coroutines/Job;Ljava/util/concurrent/CancellationException;ILjava/lang/Object;)V

    .line 229
    :cond_0
    iput-object v1, p0, Lcom/rokid/phone/ai/AiVisionActivity;->reportJob:Lkotlinx/coroutines/Job;

    .line 230
    iput-object v1, p0, Lcom/rokid/phone/ai/AiVisionActivity;->currentReport:Lcom/rokid/phone/ai/AiVisionPdfGenerator$Result;

    .line 231
    iget-object v0, p0, Lcom/rokid/phone/ai/AiVisionActivity;->adapter:Lcom/rokid/phone/adapter/AiVisionAdapter;

    if-eqz v0, :cond_1

    invoke-direct {p0}, Lcom/rokid/phone/ai/AiVisionActivity;->updateReportButtons()V

    .line 232
    :cond_1
    return-void
.end method

.method private final loadStoredRecords()V
    .locals 14

    .line 122
    iget-object v0, p0, Lcom/rokid/phone/ai/AiVisionActivity;->recordMap:Ljava/util/LinkedHashMap;

    invoke-virtual {v0}, Ljava/util/LinkedHashMap;->clear()V

    .line 123
    sget-object v0, Lcom/rokid/phone/ai/AiVisionStore;->INSTANCE:Lcom/rokid/phone/ai/AiVisionStore;

    move-object v1, p0

    check-cast v1, Landroid/content/Context;

    invoke-virtual {v0, v1}, Lcom/rokid/phone/ai/AiVisionStore;->load(Landroid/content/Context;)Ljava/util/List;

    move-result-object v0

    .line 124
    .local v0, "stored":Ljava/util/List;
    move-object v1, v0

    check-cast v1, Ljava/lang/Iterable;

    .local v1, "$this$filter$iv":Ljava/lang/Iterable;
    const/4 v2, 0x0

    .line 322
    .local v2, "$i$f$filter":I
    new-instance v3, Ljava/util/ArrayList;

    invoke-direct {v3}, Ljava/util/ArrayList;-><init>()V

    check-cast v3, Ljava/util/Collection;

    .local v3, "destination$iv$iv":Ljava/util/Collection;
    move-object v4, v1

    .local v4, "$this$filterTo$iv$iv":Ljava/lang/Iterable;
    const/4 v5, 0x0

    .line 323
    .local v5, "$i$f$filterTo":I
    invoke-interface {v4}, Ljava/lang/Iterable;->iterator()Ljava/util/Iterator;

    move-result-object v6

    :cond_0
    :goto_0
    invoke-interface {v6}, Ljava/util/Iterator;->hasNext()Z

    move-result v7

    const/4 v8, 0x0

    if-eqz v7, :cond_2

    invoke-interface {v6}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v7

    .local v7, "element$iv$iv":Ljava/lang/Object;
    move-object v9, v7

    check-cast v9, Lcom/rokid/phone/ai/AiVisionRecord;

    .local v9, "it":Lcom/rokid/phone/ai/AiVisionRecord;
    const/4 v10, 0x0

    .line 125
    .local v10, "$i$a$-filter-AiVisionActivity$loadStoredRecords$loaded$1":I
    invoke-virtual {v9}, Lcom/rokid/phone/ai/AiVisionRecord;->getCompleted()Z

    move-result v11

    if-eqz v11, :cond_1

    invoke-virtual {v9}, Lcom/rokid/phone/ai/AiVisionRecord;->getQuestionId()Ljava/lang/String;

    move-result-object v11

    check-cast v11, Ljava/lang/CharSequence;

    invoke-static {v11}, Lkotlin/text/StringsKt;->isBlank(Ljava/lang/CharSequence;)Z

    move-result v11

    const/4 v12, 0x1

    xor-int/2addr v11, v12

    if-eqz v11, :cond_1

    invoke-virtual {v9}, Lcom/rokid/phone/ai/AiVisionRecord;->getImageUrl()Ljava/lang/String;

    move-result-object v11

    check-cast v11, Ljava/lang/CharSequence;

    invoke-static {v11}, Lkotlin/text/StringsKt;->isBlank(Ljava/lang/CharSequence;)Z

    move-result v11

    xor-int/2addr v11, v12

    if-eqz v11, :cond_1

    move v8, v12

    .line 323
    .end local v9    # "it":Lcom/rokid/phone/ai/AiVisionRecord;
    .end local v10    # "$i$a$-filter-AiVisionActivity$loadStoredRecords$loaded$1":I
    :cond_1
    if-eqz v8, :cond_0

    invoke-interface {v3, v7}, Ljava/util/Collection;->add(Ljava/lang/Object;)Z

    goto :goto_0

    .line 324
    .end local v7    # "element$iv$iv":Ljava/lang/Object;
    :cond_2
    nop

    .end local v3    # "destination$iv$iv":Ljava/util/Collection;
    .end local v4    # "$this$filterTo$iv$iv":Ljava/lang/Iterable;
    .end local v5    # "$i$f$filterTo":I
    check-cast v3, Ljava/util/List;

    .line 322
    nop

    .line 124
    .end local v1    # "$this$filter$iv":Ljava/lang/Iterable;
    .end local v2    # "$i$f$filter":I
    move-object v1, v3

    .line 127
    .local v1, "loaded":Ljava/util/List;
    move-object v2, v1

    check-cast v2, Ljava/lang/Iterable;

    .local v2, "$this$forEach$iv":Ljava/lang/Iterable;
    const/4 v3, 0x0

    .line 325
    .local v3, "$i$f$forEach":I
    invoke-interface {v2}, Ljava/lang/Iterable;->iterator()Ljava/util/Iterator;

    move-result-object v4

    :goto_1
    invoke-interface {v4}, Ljava/util/Iterator;->hasNext()Z

    move-result v5

    if-eqz v5, :cond_4

    invoke-interface {v4}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v5

    .local v5, "element$iv":Ljava/lang/Object;
    move-object v6, v5

    check-cast v6, Lcom/rokid/phone/ai/AiVisionRecord;

    .local v6, "record":Lcom/rokid/phone/ai/AiVisionRecord;
    const/4 v7, 0x0

    .line 128
    .local v7, "$i$a$-forEach-AiVisionActivity$loadStoredRecords$1":I
    invoke-virtual {v6}, Lcom/rokid/phone/ai/AiVisionRecord;->getQuestion()Ljava/lang/String;

    move-result-object v9

    invoke-direct {p0, v9}, Lcom/rokid/phone/ai/AiVisionActivity;->questionForDisplay(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v9

    invoke-virtual {v6, v9}, Lcom/rokid/phone/ai/AiVisionRecord;->setQuestion(Ljava/lang/String;)V

    .line 129
    invoke-virtual {v6}, Lcom/rokid/phone/ai/AiVisionRecord;->getAnswer()Ljava/lang/String;

    move-result-object v9

    check-cast v9, Ljava/lang/CharSequence;

    invoke-static {v9}, Lkotlin/text/StringsKt;->isBlank(Ljava/lang/CharSequence;)Z

    move-result v9

    if-eqz v9, :cond_3

    invoke-virtual {v6}, Lcom/rokid/phone/ai/AiVisionRecord;->getCompleted()Z

    move-result v9

    if-eqz v9, :cond_3

    .line 130
    sget v9, Lcom/rokid/phone/R$string;->demo_ai_vision_no_answer:I

    new-array v10, v8, [Ljava/lang/Object;

    invoke-static {v9, v10}, Lcom/rokid/phone/utils/DemoStringsKt;->demoString(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v9

    invoke-virtual {v6, v9}, Lcom/rokid/phone/ai/AiVisionRecord;->setAnswer(Ljava/lang/String;)V

    .line 132
    :cond_3
    invoke-direct {p0, v6}, Lcom/rokid/phone/ai/AiVisionActivity;->updateGeneratedReportMetadata(Lcom/rokid/phone/ai/AiVisionRecord;)V

    .line 133
    nop

    .line 325
    .end local v6    # "record":Lcom/rokid/phone/ai/AiVisionRecord;
    .end local v7    # "$i$a$-forEach-AiVisionActivity$loadStoredRecords$1":I
    nop

    .end local v5    # "element$iv":Ljava/lang/Object;
    goto :goto_1

    .line 326
    :cond_4
    nop

    .line 134
    .end local v2    # "$this$forEach$iv":Ljava/lang/Iterable;
    .end local v3    # "$i$f$forEach":I
    sget-object v2, Lcom/rokid/phone/ai/AiVisionAnswerPolicy;->INSTANCE:Lcom/rokid/phone/ai/AiVisionAnswerPolicy;

    invoke-virtual {v2, v1}, Lcom/rokid/phone/ai/AiVisionAnswerPolicy;->deduplicateStoredRecords(Ljava/util/List;)Ljava/util/List;

    move-result-object v2

    .line 135
    .local v2, "deduplicated":Ljava/util/List;
    move-object v3, v2

    check-cast v3, Ljava/lang/Iterable;

    .local v3, "$this$forEach$iv":Ljava/lang/Iterable;
    const/4 v4, 0x0

    .line 327
    .local v4, "$i$f$forEach":I
    invoke-interface {v3}, Ljava/lang/Iterable;->iterator()Ljava/util/Iterator;

    move-result-object v5

    :goto_2
    invoke-interface {v5}, Ljava/util/Iterator;->hasNext()Z

    move-result v6

    if-eqz v6, :cond_5

    invoke-interface {v5}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v6

    .local v6, "element$iv":Ljava/lang/Object;
    move-object v7, v6

    check-cast v7, Lcom/rokid/phone/ai/AiVisionRecord;

    .local v7, "it":Lcom/rokid/phone/ai/AiVisionRecord;
    const/4 v8, 0x0

    .line 135
    .local v8, "$i$a$-forEach-AiVisionActivity$loadStoredRecords$2":I
    iget-object v9, p0, Lcom/rokid/phone/ai/AiVisionActivity;->recordMap:Ljava/util/LinkedHashMap;

    check-cast v9, Ljava/util/Map;

    invoke-virtual {v7}, Lcom/rokid/phone/ai/AiVisionRecord;->getQuestionId()Ljava/lang/String;

    move-result-object v10

    invoke-interface {v9, v10, v7}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 327
    .end local v7    # "it":Lcom/rokid/phone/ai/AiVisionRecord;
    .end local v8    # "$i$a$-forEach-AiVisionActivity$loadStoredRecords$2":I
    nop

    .end local v6    # "element$iv":Ljava/lang/Object;
    goto :goto_2

    .line 328
    :cond_5
    nop

    .line 136
    .end local v3    # "$this$forEach$iv":Ljava/lang/Iterable;
    .end local v4    # "$i$f$forEach":I
    invoke-direct {p0}, Lcom/rokid/phone/ai/AiVisionActivity;->compactSupersededCommercialResults()Z

    move-result v3

    const-string v4, "<get-values>(...)"

    if-nez v3, :cond_9

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v3

    invoke-interface {v1}, Ljava/util/List;->size()I

    move-result v5

    if-eq v3, v5, :cond_6

    goto :goto_4

    .line 138
    :cond_6
    invoke-interface {v2}, Ljava/util/List;->size()I

    move-result v3

    invoke-interface {v1}, Ljava/util/List;->size()I

    move-result v5

    if-eq v3, v5, :cond_c

    .line 139
    sget-object v3, Lcom/rokid/phone/ai/AiVisionStore;->INSTANCE:Lcom/rokid/phone/ai/AiVisionStore;

    move-object v5, p0

    check-cast v5, Landroid/content/Context;

    iget-object v6, p0, Lcom/rokid/phone/ai/AiVisionActivity;->recordMap:Ljava/util/LinkedHashMap;

    invoke-virtual {v6}, Ljava/util/LinkedHashMap;->values()Ljava/util/Collection;

    move-result-object v6

    invoke-static {v6, v4}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    move-object v4, v6

    check-cast v4, Ljava/lang/Iterable;

    .local v4, "$this$filter$iv":Ljava/lang/Iterable;
    const/4 v6, 0x0

    .line 332
    .local v6, "$i$f$filter":I
    new-instance v7, Ljava/util/ArrayList;

    invoke-direct {v7}, Ljava/util/ArrayList;-><init>()V

    check-cast v7, Ljava/util/Collection;

    .local v7, "destination$iv$iv":Ljava/util/Collection;
    move-object v8, v4

    .local v8, "$this$filterTo$iv$iv":Ljava/lang/Iterable;
    const/4 v9, 0x0

    .line 333
    .local v9, "$i$f$filterTo":I
    invoke-interface {v8}, Ljava/lang/Iterable;->iterator()Ljava/util/Iterator;

    move-result-object v10

    :cond_7
    :goto_3
    invoke-interface {v10}, Ljava/util/Iterator;->hasNext()Z

    move-result v11

    if-eqz v11, :cond_8

    invoke-interface {v10}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v11

    .local v11, "element$iv$iv":Ljava/lang/Object;
    move-object v12, v11

    check-cast v12, Lcom/rokid/phone/ai/AiVisionRecord;

    .local v12, "it":Lcom/rokid/phone/ai/AiVisionRecord;
    const/4 v13, 0x0

    .line 139
    .local v13, "$i$a$-filter-AiVisionActivity$loadStoredRecords$4":I
    invoke-virtual {v12}, Lcom/rokid/phone/ai/AiVisionRecord;->getCompleted()Z

    move-result v12

    .line 333
    .end local v12    # "it":Lcom/rokid/phone/ai/AiVisionRecord;
    .end local v13    # "$i$a$-filter-AiVisionActivity$loadStoredRecords$4":I
    if-eqz v12, :cond_7

    invoke-interface {v7, v11}, Ljava/util/Collection;->add(Ljava/lang/Object;)Z

    goto :goto_3

    .line 334
    .end local v11    # "element$iv$iv":Ljava/lang/Object;
    :cond_8
    nop

    .end local v7    # "destination$iv$iv":Ljava/util/Collection;
    .end local v8    # "$this$filterTo$iv$iv":Ljava/lang/Iterable;
    .end local v9    # "$i$f$filterTo":I
    check-cast v7, Ljava/util/List;

    .line 332
    nop

    .end local v4    # "$this$filter$iv":Ljava/lang/Iterable;
    .end local v6    # "$i$f$filter":I
    check-cast v7, Ljava/util/Collection;

    .line 139
    invoke-virtual {v3, v5, v7}, Lcom/rokid/phone/ai/AiVisionStore;->save(Landroid/content/Context;Ljava/util/Collection;)V

    goto :goto_6

    .line 137
    :cond_9
    :goto_4
    sget-object v3, Lcom/rokid/phone/ai/AiVisionStore;->INSTANCE:Lcom/rokid/phone/ai/AiVisionStore;

    move-object v5, p0

    check-cast v5, Landroid/content/Context;

    iget-object v6, p0, Lcom/rokid/phone/ai/AiVisionActivity;->recordMap:Ljava/util/LinkedHashMap;

    invoke-virtual {v6}, Ljava/util/LinkedHashMap;->values()Ljava/util/Collection;

    move-result-object v6

    invoke-static {v6, v4}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    move-object v4, v6

    check-cast v4, Ljava/lang/Iterable;

    .restart local v4    # "$this$filter$iv":Ljava/lang/Iterable;
    const/4 v6, 0x0

    .line 329
    .restart local v6    # "$i$f$filter":I
    new-instance v7, Ljava/util/ArrayList;

    invoke-direct {v7}, Ljava/util/ArrayList;-><init>()V

    check-cast v7, Ljava/util/Collection;

    .restart local v7    # "destination$iv$iv":Ljava/util/Collection;
    move-object v8, v4

    .restart local v8    # "$this$filterTo$iv$iv":Ljava/lang/Iterable;
    const/4 v9, 0x0

    .line 330
    .restart local v9    # "$i$f$filterTo":I
    invoke-interface {v8}, Ljava/lang/Iterable;->iterator()Ljava/util/Iterator;

    move-result-object v10

    :cond_a
    :goto_5
    invoke-interface {v10}, Ljava/util/Iterator;->hasNext()Z

    move-result v11

    if-eqz v11, :cond_b

    invoke-interface {v10}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v11

    .restart local v11    # "element$iv$iv":Ljava/lang/Object;
    move-object v12, v11

    check-cast v12, Lcom/rokid/phone/ai/AiVisionRecord;

    .restart local v12    # "it":Lcom/rokid/phone/ai/AiVisionRecord;
    const/4 v13, 0x0

    .line 137
    .local v13, "$i$a$-filter-AiVisionActivity$loadStoredRecords$3":I
    invoke-virtual {v12}, Lcom/rokid/phone/ai/AiVisionRecord;->getCompleted()Z

    move-result v12

    .line 330
    .end local v12    # "it":Lcom/rokid/phone/ai/AiVisionRecord;
    .end local v13    # "$i$a$-filter-AiVisionActivity$loadStoredRecords$3":I
    if-eqz v12, :cond_a

    invoke-interface {v7, v11}, Ljava/util/Collection;->add(Ljava/lang/Object;)Z

    goto :goto_5

    .line 331
    .end local v11    # "element$iv$iv":Ljava/lang/Object;
    :cond_b
    nop

    .end local v7    # "destination$iv$iv":Ljava/util/Collection;
    .end local v8    # "$this$filterTo$iv$iv":Ljava/lang/Iterable;
    .end local v9    # "$i$f$filterTo":I
    check-cast v7, Ljava/util/List;

    .line 329
    nop

    .end local v4    # "$this$filter$iv":Ljava/lang/Iterable;
    .end local v6    # "$i$f$filter":I
    check-cast v7, Ljava/util/Collection;

    .line 137
    invoke-virtual {v3, v5, v7}, Lcom/rokid/phone/ai/AiVisionStore;->save(Landroid/content/Context;Ljava/util/Collection;)V

    .line 141
    :cond_c
    :goto_6
    invoke-direct {p0}, Lcom/rokid/phone/ai/AiVisionActivity;->publishRecords()V

    .line 142
    return-void
.end method

.method private static final onInit$lambda$1(Lcom/rokid/phone/ai/AiVisionActivity;Ljava/lang/String;)Lkotlin/Unit;
    .locals 1
    .param p0, "this$0"    # Lcom/rokid/phone/ai/AiVisionActivity;
    .param p1, "questionId"    # Ljava/lang/String;

    const-string v0, "questionId"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 85
    invoke-direct {p0, p1}, Lcom/rokid/phone/ai/AiVisionActivity;->selectRecord(Ljava/lang/String;)V

    .line 86
    sget-object v0, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    return-object v0
.end method

.method private static final onInit$lambda$2(Lcom/rokid/phone/ai/AiVisionActivity;Landroid/view/View;)V
    .locals 0
    .param p0, "this$0"    # Lcom/rokid/phone/ai/AiVisionActivity;
    .param p1, "it"    # Landroid/view/View;

    .line 89
    invoke-virtual {p0}, Lcom/rokid/phone/ai/AiVisionActivity;->finish()V

    return-void
.end method

.method private static final onInit$lambda$3(Lcom/rokid/phone/ai/AiVisionActivity;Landroid/view/View;)V
    .locals 1
    .param p0, "this$0"    # Lcom/rokid/phone/ai/AiVisionActivity;
    .param p1, "it"    # Landroid/view/View;

    .line 90
    const/4 v0, 0x0

    invoke-direct {p0, v0}, Lcom/rokid/phone/ai/AiVisionActivity;->generateReport(Z)V

    return-void
.end method

.method private static final onInit$lambda$4(Lcom/rokid/phone/ai/AiVisionActivity;Landroid/view/View;)V
    .locals 1
    .param p0, "this$0"    # Lcom/rokid/phone/ai/AiVisionActivity;
    .param p1, "it"    # Landroid/view/View;

    .line 91
    const/4 v0, 0x1

    invoke-direct {p0, v0}, Lcom/rokid/phone/ai/AiVisionActivity;->generateReport(Z)V

    return-void
.end method

.method private final openReport(Landroid/net/Uri;)V
    .locals 6
    .param p1, "uri"    # Landroid/net/Uri;

    .line 305
    :try_start_0
    sget-object v0, Lkotlin/Result;->Companion:Lkotlin/Result$Companion;

    move-object v0, p0

    check-cast v0, Lcom/rokid/phone/ai/AiVisionActivity;

    .local v0, "$this$openReport_u24lambda_u2419":Lcom/rokid/phone/ai/AiVisionActivity;
    const/4 v1, 0x0

    .line 306
    .local v1, "$i$a$-runCatching-AiVisionActivity$openReport$1":I
    nop

    .line 307
    new-instance v2, Landroid/content/Intent;

    const-string v3, "android.intent.action.VIEW"

    invoke-direct {v2, v3}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    move-object v3, v2

    .local v3, "$this$openReport_u24lambda_u2419_u24lambda_u2418":Landroid/content/Intent;
    const/4 v4, 0x0

    .line 308
    .local v4, "$i$a$-apply-AiVisionActivity$openReport$1$1":I
    const-string v5, "application/pdf"

    invoke-virtual {v3, p1, v5}, Landroid/content/Intent;->setDataAndType(Landroid/net/Uri;Ljava/lang/String;)Landroid/content/Intent;

    .line 309
    const/4 v5, 0x1

    invoke-virtual {v3, v5}, Landroid/content/Intent;->addFlags(I)Landroid/content/Intent;

    .line 310
    nop

    .line 307
    .end local v3    # "$this$openReport_u24lambda_u2419_u24lambda_u2418":Landroid/content/Intent;
    .end local v4    # "$i$a$-apply-AiVisionActivity$openReport$1$1":I
    nop

    .line 306
    invoke-virtual {v0, v2}, Lcom/rokid/phone/ai/AiVisionActivity;->startActivity(Landroid/content/Intent;)V

    .line 312
    nop

    .end local v0    # "$this$openReport_u24lambda_u2419":Lcom/rokid/phone/ai/AiVisionActivity;
    .end local v1    # "$i$a$-runCatching-AiVisionActivity$openReport$1":I
    sget-object v0, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    .line 305
    invoke-static {v0}, Lkotlin/Result;->constructor-impl(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto :goto_0

    :catchall_0
    move-exception v0

    sget-object v1, Lkotlin/Result;->Companion:Lkotlin/Result$Companion;

    invoke-static {v0}, Lkotlin/ResultKt;->createFailure(Ljava/lang/Throwable;)Ljava/lang/Object;

    move-result-object v0

    invoke-static {v0}, Lkotlin/Result;->constructor-impl(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    .line 312
    :goto_0
    invoke-static {v0}, Lkotlin/Result;->exceptionOrNull-impl(Ljava/lang/Object;)Ljava/lang/Throwable;

    move-result-object v0

    if-eqz v0, :cond_0

    .local v0, "it":Ljava/lang/Throwable;
    const/4 v1, 0x0

    .line 314
    .local v1, "$i$a$-onFailure-AiVisionActivity$openReport$2":I
    move-object v2, p0

    check-cast v2, Landroid/content/Context;

    .line 315
    sget v3, Lcom/rokid/phone/R$string;->demo_ai_vision_download_started:I

    const/4 v4, 0x0

    new-array v5, v4, [Ljava/lang/Object;

    invoke-static {v3, v5}, Lcom/rokid/phone/utils/DemoStringsKt;->demoString(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    check-cast v3, Ljava/lang/CharSequence;

    .line 316
    nop

    .line 313
    invoke-static {v2, v3, v4}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object v2

    .line 317
    invoke-virtual {v2}, Landroid/widget/Toast;->show()V

    .line 318
    nop

    .line 312
    .end local v0    # "it":Ljava/lang/Throwable;
    .end local v1    # "$i$a$-onFailure-AiVisionActivity$openReport$2":I
    nop

    .line 319
    :cond_0
    return-void
.end method

.method private final publishRecords()V
    .locals 10

    .line 177
    iget-object v0, p0, Lcom/rokid/phone/ai/AiVisionActivity;->visibleRecords:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->clear()V

    .line 178
    iget-object v0, p0, Lcom/rokid/phone/ai/AiVisionActivity;->visibleRecords:Ljava/util/List;

    .line 179
    iget-object v1, p0, Lcom/rokid/phone/ai/AiVisionActivity;->recordMap:Ljava/util/LinkedHashMap;

    invoke-virtual {v1}, Ljava/util/LinkedHashMap;->values()Ljava/util/Collection;

    move-result-object v1

    const-string v2, "<get-values>(...)"

    invoke-static {v1, v2}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    check-cast v1, Ljava/lang/Iterable;

    .local v1, "$this$filter$iv":Ljava/lang/Iterable;
    const/4 v2, 0x0

    .line 341
    .local v2, "$i$f$filter":I
    new-instance v3, Ljava/util/ArrayList;

    invoke-direct {v3}, Ljava/util/ArrayList;-><init>()V

    check-cast v3, Ljava/util/Collection;

    .local v3, "destination$iv$iv":Ljava/util/Collection;
    move-object v4, v1

    .local v4, "$this$filterTo$iv$iv":Ljava/lang/Iterable;
    const/4 v5, 0x0

    .line 342
    .local v5, "$i$f$filterTo":I
    invoke-interface {v4}, Ljava/lang/Iterable;->iterator()Ljava/util/Iterator;

    move-result-object v6

    :cond_0
    :goto_0
    invoke-interface {v6}, Ljava/util/Iterator;->hasNext()Z

    move-result v7

    if-eqz v7, :cond_1

    invoke-interface {v6}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v7

    .local v7, "element$iv$iv":Ljava/lang/Object;
    move-object v8, v7

    check-cast v8, Lcom/rokid/phone/ai/AiVisionRecord;

    .local v8, "it":Lcom/rokid/phone/ai/AiVisionRecord;
    const/4 v9, 0x0

    .line 179
    .local v9, "$i$a$-filter-AiVisionActivity$publishRecords$1":I
    invoke-virtual {v8}, Lcom/rokid/phone/ai/AiVisionRecord;->getCompleted()Z

    move-result v8

    .line 342
    .end local v8    # "it":Lcom/rokid/phone/ai/AiVisionRecord;
    .end local v9    # "$i$a$-filter-AiVisionActivity$publishRecords$1":I
    if-eqz v8, :cond_0

    invoke-interface {v3, v7}, Ljava/util/Collection;->add(Ljava/lang/Object;)Z

    goto :goto_0

    .line 343
    .end local v7    # "element$iv$iv":Ljava/lang/Object;
    :cond_1
    nop

    .end local v3    # "destination$iv$iv":Ljava/util/Collection;
    .end local v4    # "$this$filterTo$iv$iv":Ljava/lang/Iterable;
    .end local v5    # "$i$f$filterTo":I
    check-cast v3, Ljava/util/List;

    .line 341
    nop

    .end local v1    # "$this$filter$iv":Ljava/lang/Iterable;
    .end local v2    # "$i$f$filter":I
    check-cast v3, Ljava/lang/Iterable;

    .line 179
    move-object v1, v3

    .local v1, "$this$sortedByDescending$iv":Ljava/lang/Iterable;
    const/4 v2, 0x0

    .line 344
    .local v2, "$i$f$sortedByDescending":I
    new-instance v3, Lcom/rokid/phone/ai/AiVisionActivity$publishRecords$$inlined$sortedByDescending$1;

    invoke-direct {v3}, Lcom/rokid/phone/ai/AiVisionActivity$publishRecords$$inlined$sortedByDescending$1;-><init>()V

    check-cast v3, Ljava/util/Comparator;

    invoke-static {v1, v3}, Lkotlin/collections/CollectionsKt;->sortedWith(Ljava/lang/Iterable;Ljava/util/Comparator;)Ljava/util/List;

    move-result-object v1

    .end local v1    # "$this$sortedByDescending$iv":Ljava/lang/Iterable;
    .end local v2    # "$i$f$sortedByDescending":I
    check-cast v1, Ljava/util/Collection;

    .line 178
    invoke-interface {v0, v1}, Ljava/util/List;->addAll(Ljava/util/Collection;)Z

    .line 181
    iget-object v0, p0, Lcom/rokid/phone/ai/AiVisionActivity;->visibleRecords:Ljava/util/List;

    check-cast v0, Ljava/lang/Iterable;

    .local v0, "$this$none$iv":Ljava/lang/Iterable;
    const/4 v1, 0x0

    .line 345
    .local v1, "$i$f$none":I
    instance-of v2, v0, Ljava/util/Collection;

    const/4 v3, 0x0

    const/4 v4, 0x1

    if-eqz v2, :cond_2

    move-object v2, v0

    check-cast v2, Ljava/util/Collection;

    invoke-interface {v2}, Ljava/util/Collection;->isEmpty()Z

    move-result v2

    if-eqz v2, :cond_2

    goto :goto_1

    .line 346
    :cond_2
    invoke-interface {v0}, Ljava/lang/Iterable;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :cond_3
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v5

    if-eqz v5, :cond_4

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v5

    .local v5, "element$iv":Ljava/lang/Object;
    move-object v6, v5

    check-cast v6, Lcom/rokid/phone/ai/AiVisionRecord;

    .local v6, "it":Lcom/rokid/phone/ai/AiVisionRecord;
    const/4 v7, 0x0

    .line 181
    .local v7, "$i$a$-none-AiVisionActivity$publishRecords$3":I
    invoke-virtual {v6}, Lcom/rokid/phone/ai/AiVisionRecord;->getQuestionId()Ljava/lang/String;

    move-result-object v8

    iget-object v9, p0, Lcom/rokid/phone/ai/AiVisionActivity;->selectedQuestionId:Ljava/lang/String;

    invoke-static {v8, v9}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v6

    .line 346
    .end local v6    # "it":Lcom/rokid/phone/ai/AiVisionRecord;
    .end local v7    # "$i$a$-none-AiVisionActivity$publishRecords$3":I
    if-eqz v6, :cond_3

    move v4, v3

    goto :goto_1

    .line 347
    .end local v5    # "element$iv":Ljava/lang/Object;
    :cond_4
    nop

    .line 181
    .end local v0    # "$this$none$iv":Ljava/lang/Iterable;
    .end local v1    # "$i$f$none":I
    :goto_1
    const/4 v0, 0x0

    if-eqz v4, :cond_5

    .line 182
    iput-object v0, p0, Lcom/rokid/phone/ai/AiVisionActivity;->selectedQuestionId:Ljava/lang/String;

    .line 184
    :cond_5
    iget-object v1, p0, Lcom/rokid/phone/ai/AiVisionActivity;->adapter:Lcom/rokid/phone/adapter/AiVisionAdapter;

    if-nez v1, :cond_6

    const-string v1, "adapter"

    invoke-static {v1}, Lkotlin/jvm/internal/Intrinsics;->throwUninitializedPropertyAccessException(Ljava/lang/String;)V

    goto :goto_2

    :cond_6
    move-object v0, v1

    :goto_2
    iget-object v1, p0, Lcom/rokid/phone/ai/AiVisionActivity;->visibleRecords:Ljava/util/List;

    iget-object v2, p0, Lcom/rokid/phone/ai/AiVisionActivity;->selectedQuestionId:Ljava/lang/String;

    invoke-virtual {v0, v1, v2}, Lcom/rokid/phone/adapter/AiVisionAdapter;->submitRecords(Ljava/util/List;Ljava/lang/String;)V

    .line 185
    invoke-virtual {p0}, Lcom/rokid/phone/ai/AiVisionActivity;->getBinding()Landroidx/viewbinding/ViewBinding;

    move-result-object v0

    check-cast v0, Lcom/rokid/phone/databinding/ActivityAiVisionBinding;

    iget-object v0, v0, Lcom/rokid/phone/databinding/ActivityAiVisionBinding;->tvEmpty:Landroid/widget/TextView;

    iget-object v1, p0, Lcom/rokid/phone/ai/AiVisionActivity;->visibleRecords:Ljava/util/List;

    invoke-interface {v1}, Ljava/util/List;->isEmpty()Z

    move-result v1

    if-eqz v1, :cond_7

    goto :goto_3

    :cond_7
    const/16 v3, 0x8

    :goto_3
    invoke-virtual {v0, v3}, Landroid/widget/TextView;->setVisibility(I)V

    .line 186
    invoke-direct {p0}, Lcom/rokid/phone/ai/AiVisionActivity;->updateReportButtons()V

    .line 187
    return-void
.end method

.method private final questionForDisplay(Ljava/lang/String;)Ljava/lang/String;
    .locals 5
    .param p1, "question"    # Ljava/lang/String;

    .line 195
    move-object v0, p1

    check-cast v0, Ljava/lang/CharSequence;

    const-string v1, "\u62a5\u544a\u6807\u9898"

    check-cast v1, Ljava/lang/CharSequence;

    const/4 v2, 0x0

    const/4 v3, 0x2

    const/4 v4, 0x0

    invoke-static {v0, v1, v2, v3, v4}, Lkotlin/text/StringsKt;->contains$default(Ljava/lang/CharSequence;Ljava/lang/CharSequence;ZILjava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    move-object v0, p1

    check-cast v0, Ljava/lang/CharSequence;

    const-string v1, "\u6574\u6539\u5efa\u8bae"

    check-cast v1, Ljava/lang/CharSequence;

    invoke-static {v0, v1, v2, v3, v4}, Lkotlin/text/StringsKt;->contains$default(Ljava/lang/CharSequence;Ljava/lang/CharSequence;ZILjava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_1

    .line 196
    :cond_0
    move-object v0, p1

    check-cast v0, Ljava/lang/CharSequence;

    const-string v1, "Report title"

    check-cast v1, Ljava/lang/CharSequence;

    invoke-static {v0, v1, v2, v3, v4}, Lkotlin/text/StringsKt;->contains$default(Ljava/lang/CharSequence;Ljava/lang/CharSequence;ZILjava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_2

    move-object v0, p1

    check-cast v0, Ljava/lang/CharSequence;

    const-string v1, "Recommended actions"

    check-cast v1, Ljava/lang/CharSequence;

    invoke-static {v0, v1, v2, v3, v4}, Lkotlin/text/StringsKt;->contains$default(Ljava/lang/CharSequence;Ljava/lang/CharSequence;ZILjava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_2

    :cond_1
    const/4 v0, 0x1

    goto :goto_0

    :cond_2
    move v0, v2

    .line 194
    :goto_0
    nop

    .line 197
    .local v0, "isSdkInspectionPrompt":Z
    if-eqz v0, :cond_3

    .line 198
    sget v1, Lcom/rokid/phone/R$string;->demo_ai_vision_industrial_question:I

    new-array v2, v2, [Ljava/lang/Object;

    invoke-static {v1, v2}, Lcom/rokid/phone/utils/DemoStringsKt;->demoString(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    goto :goto_1

    .line 200
    :cond_3
    move-object v1, p1

    .line 197
    :goto_1
    return-object v1
.end method

.method private final selectRecord(Ljava/lang/String;)V
    .locals 1
    .param p1, "questionId"    # Ljava/lang/String;

    .line 209
    iget-object v0, p0, Lcom/rokid/phone/ai/AiVisionActivity;->selectedQuestionId:Ljava/lang/String;

    invoke-static {v0, p1}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    const/4 v0, 0x0

    goto :goto_0

    :cond_0
    move-object v0, p1

    :goto_0
    iput-object v0, p0, Lcom/rokid/phone/ai/AiVisionActivity;->selectedQuestionId:Ljava/lang/String;

    .line 210
    invoke-direct {p0}, Lcom/rokid/phone/ai/AiVisionActivity;->invalidateReport()V

    .line 211
    invoke-direct {p0}, Lcom/rokid/phone/ai/AiVisionActivity;->publishRecords()V

    .line 212
    return-void
.end method

.method private final selectedRecord()Lcom/rokid/phone/ai/AiVisionRecord;
    .locals 8

    .line 215
    iget-object v0, p0, Lcom/rokid/phone/ai/AiVisionActivity;->visibleRecords:Ljava/util/List;

    check-cast v0, Ljava/lang/Iterable;

    .local v0, "$this$firstOrNull$iv":Ljava/lang/Iterable;
    const/4 v1, 0x0

    .line 348
    .local v1, "$i$f$firstOrNull":I
    invoke-interface {v0}, Ljava/lang/Iterable;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :cond_0
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_1

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    .local v3, "element$iv":Ljava/lang/Object;
    move-object v4, v3

    check-cast v4, Lcom/rokid/phone/ai/AiVisionRecord;

    .local v4, "it":Lcom/rokid/phone/ai/AiVisionRecord;
    const/4 v5, 0x0

    .line 215
    .local v5, "$i$a$-firstOrNull-AiVisionActivity$selectedRecord$1":I
    invoke-virtual {v4}, Lcom/rokid/phone/ai/AiVisionRecord;->getQuestionId()Ljava/lang/String;

    move-result-object v6

    iget-object v7, p0, Lcom/rokid/phone/ai/AiVisionActivity;->selectedQuestionId:Ljava/lang/String;

    invoke-static {v6, v7}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v4

    .line 348
    .end local v4    # "it":Lcom/rokid/phone/ai/AiVisionRecord;
    .end local v5    # "$i$a$-firstOrNull-AiVisionActivity$selectedRecord$1":I
    if-eqz v4, :cond_0

    goto :goto_0

    .line 349
    .end local v3    # "element$iv":Ljava/lang/Object;
    :cond_1
    const/4 v3, 0x0

    .end local v0    # "$this$firstOrNull$iv":Ljava/lang/Iterable;
    .end local v1    # "$i$f$firstOrNull":I
    :goto_0
    check-cast v3, Lcom/rokid/phone/ai/AiVisionRecord;

    .line 215
    return-object v3
.end method

.method private final updateGeneratedReportMetadata(Lcom/rokid/phone/ai/AiVisionRecord;)V
    .locals 2
    .param p1, "record"    # Lcom/rokid/phone/ai/AiVisionRecord;

    .line 169
    invoke-virtual {p1}, Lcom/rokid/phone/ai/AiVisionRecord;->getAnswer()Ljava/lang/String;

    move-result-object v0

    check-cast v0, Ljava/lang/CharSequence;

    invoke-static {v0}, Lkotlin/text/StringsKt;->isBlank(Ljava/lang/CharSequence;)Z

    move-result v0

    xor-int/lit8 v0, v0, 0x1

    if-eqz v0, :cond_0

    sget-object v0, Lcom/rokid/phone/ai/AiVisionAnswerPolicy;->INSTANCE:Lcom/rokid/phone/ai/AiVisionAnswerPolicy;

    invoke-virtual {v0, p1}, Lcom/rokid/phone/ai/AiVisionAnswerPolicy;->isReportReady(Lcom/rokid/phone/ai/AiVisionRecord;)Z

    move-result v0

    if-nez v0, :cond_0

    .line 170
    sget-object v0, Lcom/rokid/phone/ai/AiVisionAnswerPolicy;->INSTANCE:Lcom/rokid/phone/ai/AiVisionAnswerPolicy;

    invoke-virtual {p1}, Lcom/rokid/phone/ai/AiVisionRecord;->getAnswer()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/rokid/phone/ai/AiVisionAnswerPolicy;->formatSdkFallback(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Lcom/rokid/phone/ai/AiVisionRecord;->setAnswer(Ljava/lang/String;)V

    .line 172
    :cond_0
    sget-object v0, Lcom/rokid/phone/ai/AiVisionAnswerPolicy;->INSTANCE:Lcom/rokid/phone/ai/AiVisionAnswerPolicy;

    invoke-virtual {v0, p1}, Lcom/rokid/phone/ai/AiVisionAnswerPolicy;->resolveReportTitle(Lcom/rokid/phone/ai/AiVisionRecord;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Lcom/rokid/phone/ai/AiVisionRecord;->setReportTitle(Ljava/lang/String;)V

    .line 173
    sget-object v0, Lcom/rokid/phone/ai/AiVisionAnswerPolicy;->INSTANCE:Lcom/rokid/phone/ai/AiVisionAnswerPolicy;

    invoke-virtual {v0, p1}, Lcom/rokid/phone/ai/AiVisionAnswerPolicy;->resolveReportSummary(Lcom/rokid/phone/ai/AiVisionRecord;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Lcom/rokid/phone/ai/AiVisionRecord;->setReportSummary(Ljava/lang/String;)V

    .line 174
    return-void
.end method

.method private final updateReportButtons()V
    .locals 5

    .line 218
    invoke-direct {p0}, Lcom/rokid/phone/ai/AiVisionActivity;->selectedRecord()Lcom/rokid/phone/ai/AiVisionRecord;

    move-result-object v0

    .line 219
    .local v0, "selected":Lcom/rokid/phone/ai/AiVisionRecord;
    invoke-virtual {p0}, Lcom/rokid/phone/ai/AiVisionActivity;->getBinding()Landroidx/viewbinding/ViewBinding;

    move-result-object v1

    check-cast v1, Lcom/rokid/phone/databinding/ActivityAiVisionBinding;

    iget-object v1, v1, Lcom/rokid/phone/databinding/ActivityAiVisionBinding;->btnGenerateReport:Landroidx/appcompat/widget/AppCompatButton;

    .line 220
    const/4 v2, 0x1

    const/4 v3, 0x0

    if-eqz v0, :cond_1

    .line 221
    sget-object v4, Lcom/rokid/phone/ai/AiVisionAnswerPolicy;->INSTANCE:Lcom/rokid/phone/ai/AiVisionAnswerPolicy;

    invoke-virtual {v4, v0}, Lcom/rokid/phone/ai/AiVisionAnswerPolicy;->isReportReady(Lcom/rokid/phone/ai/AiVisionRecord;)Z

    move-result v4

    if-eqz v4, :cond_1

    .line 222
    iget-object v4, p0, Lcom/rokid/phone/ai/AiVisionActivity;->reportJob:Lkotlinx/coroutines/Job;

    if-eqz v4, :cond_0

    invoke-interface {v4}, Lkotlinx/coroutines/Job;->isActive()Z

    move-result v4

    if-ne v4, v2, :cond_0

    move v4, v2

    goto :goto_0

    :cond_0
    move v4, v3

    :goto_0
    if-nez v4, :cond_1

    move v4, v2

    goto :goto_1

    :cond_1
    move v4, v3

    .line 219
    :goto_1
    invoke-virtual {v1, v4}, Landroidx/appcompat/widget/AppCompatButton;->setEnabled(Z)V

    .line 223
    invoke-virtual {p0}, Lcom/rokid/phone/ai/AiVisionActivity;->getBinding()Landroidx/viewbinding/ViewBinding;

    move-result-object v1

    check-cast v1, Lcom/rokid/phone/databinding/ActivityAiVisionBinding;

    iget-object v1, v1, Lcom/rokid/phone/databinding/ActivityAiVisionBinding;->btnDownloadReport:Landroidx/appcompat/widget/AppCompatButton;

    .line 224
    iget-object v4, p0, Lcom/rokid/phone/ai/AiVisionActivity;->currentReport:Lcom/rokid/phone/ai/AiVisionPdfGenerator$Result;

    if-eqz v4, :cond_3

    iget-object v4, p0, Lcom/rokid/phone/ai/AiVisionActivity;->reportJob:Lkotlinx/coroutines/Job;

    if-eqz v4, :cond_2

    invoke-interface {v4}, Lkotlinx/coroutines/Job;->isActive()Z

    move-result v4

    if-ne v4, v2, :cond_2

    move v4, v2

    goto :goto_2

    :cond_2
    move v4, v3

    :goto_2
    if-nez v4, :cond_3

    goto :goto_3

    :cond_3
    move v2, v3

    .line 223
    :goto_3
    invoke-virtual {v1, v2}, Landroidx/appcompat/widget/AppCompatButton;->setEnabled(Z)V

    .line 225
    return-void
.end method


# virtual methods
.method public bridge synthetic initViewBinding()Landroidx/viewbinding/ViewBinding;
    .locals 1

    .line 31
    invoke-virtual {p0}, Lcom/rokid/phone/ai/AiVisionActivity;->initViewBinding()Lcom/rokid/phone/databinding/ActivityAiVisionBinding;

    move-result-object v0

    check-cast v0, Landroidx/viewbinding/ViewBinding;

    return-object v0
.end method

.method public initViewBinding()Lcom/rokid/phone/databinding/ActivityAiVisionBinding;
    .locals 2

    .line 81
    invoke-virtual {p0}, Lcom/rokid/phone/ai/AiVisionActivity;->getLayoutInflater()Landroid/view/LayoutInflater;

    move-result-object v0

    invoke-static {v0}, Lcom/rokid/phone/databinding/ActivityAiVisionBinding;->inflate(Landroid/view/LayoutInflater;)Lcom/rokid/phone/databinding/ActivityAiVisionBinding;

    move-result-object v0

    const-string v1, "inflate(...)"

    invoke-static {v0, v1}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    return-object v0
.end method

.method protected onDestroy()V
    .locals 3

    .line 117
    iget-object v0, p0, Lcom/rokid/phone/ai/AiVisionActivity;->reportJob:Lkotlinx/coroutines/Job;

    if-eqz v0, :cond_0

    const/4 v1, 0x1

    const/4 v2, 0x0

    invoke-static {v0, v2, v1, v2}, Lkotlinx/coroutines/Job$DefaultImpls;->cancel$default(Lkotlinx/coroutines/Job;Ljava/util/concurrent/CancellationException;ILjava/lang/Object;)V

    .line 118
    :cond_0
    invoke-super {p0}, Lcom/rokid/phone/base/BaseActivity;->onDestroy()V

    .line 119
    return-void
.end method

.method public onInit(Landroid/os/Bundle;)V
    .locals 3
    .param p1, "savedInstanceState"    # Landroid/os/Bundle;

    .line 84
    new-instance v0, Lcom/rokid/phone/adapter/AiVisionAdapter;

    iget-object v1, p0, Lcom/rokid/phone/ai/AiVisionActivity;->visibleRecords:Ljava/util/List;

    new-instance v2, Lcom/rokid/phone/ai/AiVisionActivity$$ExternalSyntheticLambda0;

    invoke-direct {v2, p0}, Lcom/rokid/phone/ai/AiVisionActivity$$ExternalSyntheticLambda0;-><init>(Lcom/rokid/phone/ai/AiVisionActivity;)V

    invoke-direct {v0, v1, v2}, Lcom/rokid/phone/adapter/AiVisionAdapter;-><init>(Ljava/util/List;Lkotlin/jvm/functions/Function1;)V

    iput-object v0, p0, Lcom/rokid/phone/ai/AiVisionActivity;->adapter:Lcom/rokid/phone/adapter/AiVisionAdapter;

    .line 87
    invoke-virtual {p0}, Lcom/rokid/phone/ai/AiVisionActivity;->getBinding()Landroidx/viewbinding/ViewBinding;

    move-result-object v0

    check-cast v0, Lcom/rokid/phone/databinding/ActivityAiVisionBinding;

    iget-object v0, v0, Lcom/rokid/phone/databinding/ActivityAiVisionBinding;->recyclerRecords:Landroidx/recyclerview/widget/RecyclerView;

    new-instance v1, Landroidx/recyclerview/widget/LinearLayoutManager;

    move-object v2, p0

    check-cast v2, Landroid/content/Context;

    invoke-direct {v1, v2}, Landroidx/recyclerview/widget/LinearLayoutManager;-><init>(Landroid/content/Context;)V

    check-cast v1, Landroidx/recyclerview/widget/RecyclerView$LayoutManager;

    invoke-virtual {v0, v1}, Landroidx/recyclerview/widget/RecyclerView;->setLayoutManager(Landroidx/recyclerview/widget/RecyclerView$LayoutManager;)V

    .line 88
    invoke-virtual {p0}, Lcom/rokid/phone/ai/AiVisionActivity;->getBinding()Landroidx/viewbinding/ViewBinding;

    move-result-object v0

    check-cast v0, Lcom/rokid/phone/databinding/ActivityAiVisionBinding;

    iget-object v0, v0, Lcom/rokid/phone/databinding/ActivityAiVisionBinding;->recyclerRecords:Landroidx/recyclerview/widget/RecyclerView;

    iget-object v1, p0, Lcom/rokid/phone/ai/AiVisionActivity;->adapter:Lcom/rokid/phone/adapter/AiVisionAdapter;

    if-nez v1, :cond_0

    const-string v1, "adapter"

    invoke-static {v1}, Lkotlin/jvm/internal/Intrinsics;->throwUninitializedPropertyAccessException(Ljava/lang/String;)V

    const/4 v1, 0x0

    :cond_0
    check-cast v1, Landroidx/recyclerview/widget/RecyclerView$Adapter;

    invoke-virtual {v0, v1}, Landroidx/recyclerview/widget/RecyclerView;->setAdapter(Landroidx/recyclerview/widget/RecyclerView$Adapter;)V

    .line 89
    invoke-virtual {p0}, Lcom/rokid/phone/ai/AiVisionActivity;->getBinding()Landroidx/viewbinding/ViewBinding;

    move-result-object v0

    check-cast v0, Lcom/rokid/phone/databinding/ActivityAiVisionBinding;

    iget-object v0, v0, Lcom/rokid/phone/databinding/ActivityAiVisionBinding;->btnBack:Landroid/widget/ImageButton;

    new-instance v1, Lcom/rokid/phone/ai/AiVisionActivity$$ExternalSyntheticLambda1;

    invoke-direct {v1, p0}, Lcom/rokid/phone/ai/AiVisionActivity$$ExternalSyntheticLambda1;-><init>(Lcom/rokid/phone/ai/AiVisionActivity;)V

    invoke-virtual {v0, v1}, Landroid/widget/ImageButton;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 90
    invoke-virtual {p0}, Lcom/rokid/phone/ai/AiVisionActivity;->getBinding()Landroidx/viewbinding/ViewBinding;

    move-result-object v0

    check-cast v0, Lcom/rokid/phone/databinding/ActivityAiVisionBinding;

    iget-object v0, v0, Lcom/rokid/phone/databinding/ActivityAiVisionBinding;->btnGenerateReport:Landroidx/appcompat/widget/AppCompatButton;

    new-instance v1, Lcom/rokid/phone/ai/AiVisionActivity$$ExternalSyntheticLambda2;

    invoke-direct {v1, p0}, Lcom/rokid/phone/ai/AiVisionActivity$$ExternalSyntheticLambda2;-><init>(Lcom/rokid/phone/ai/AiVisionActivity;)V

    invoke-virtual {v0, v1}, Landroidx/appcompat/widget/AppCompatButton;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 91
    invoke-virtual {p0}, Lcom/rokid/phone/ai/AiVisionActivity;->getBinding()Landroidx/viewbinding/ViewBinding;

    move-result-object v0

    check-cast v0, Lcom/rokid/phone/databinding/ActivityAiVisionBinding;

    iget-object v0, v0, Lcom/rokid/phone/databinding/ActivityAiVisionBinding;->btnDownloadReport:Landroidx/appcompat/widget/AppCompatButton;

    new-instance v1, Lcom/rokid/phone/ai/AiVisionActivity$$ExternalSyntheticLambda3;

    invoke-direct {v1, p0}, Lcom/rokid/phone/ai/AiVisionActivity$$ExternalSyntheticLambda3;-><init>(Lcom/rokid/phone/ai/AiVisionActivity;)V

    invoke-virtual {v0, v1}, Landroidx/appcompat/widget/AppCompatButton;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 92
    invoke-direct {p0}, Lcom/rokid/phone/ai/AiVisionActivity;->loadStoredRecords()V

    .line 93
    return-void
.end method

.method protected onPause()V
    .locals 1

    .line 109
    iget-boolean v0, p0, Lcom/rokid/phone/ai/AiVisionActivity;->receiverRegistered:Z

    if-eqz v0, :cond_0

    .line 110
    iget-object v0, p0, Lcom/rokid/phone/ai/AiVisionActivity;->recordsUpdatedReceiver:Lcom/rokid/phone/ai/AiVisionActivity$recordsUpdatedReceiver$1;

    check-cast v0, Landroid/content/BroadcastReceiver;

    invoke-virtual {p0, v0}, Lcom/rokid/phone/ai/AiVisionActivity;->unregisterReceiver(Landroid/content/BroadcastReceiver;)V

    .line 111
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/rokid/phone/ai/AiVisionActivity;->receiverRegistered:Z

    .line 113
    :cond_0
    invoke-super {p0}, Lcom/rokid/phone/base/BaseActivity;->onPause()V

    .line 114
    return-void
.end method

.method protected onResume()V
    .locals 4

    .line 96
    invoke-super {p0}, Lcom/rokid/phone/base/BaseActivity;->onResume()V

    .line 97
    iget-boolean v0, p0, Lcom/rokid/phone/ai/AiVisionActivity;->receiverRegistered:Z

    if-nez v0, :cond_0

    .line 99
    move-object v0, p0

    check-cast v0, Landroid/content/Context;

    .line 100
    iget-object v1, p0, Lcom/rokid/phone/ai/AiVisionActivity;->recordsUpdatedReceiver:Lcom/rokid/phone/ai/AiVisionActivity$recordsUpdatedReceiver$1;

    check-cast v1, Landroid/content/BroadcastReceiver;

    .line 101
    new-instance v2, Landroid/content/IntentFilter;

    const-string v3, "com.rokid.phone.action.AI_VISION_RECORDS_UPDATED"

    invoke-direct {v2, v3}, Landroid/content/IntentFilter;-><init>(Ljava/lang/String;)V

    .line 102
    nop

    .line 98
    const/4 v3, 0x4

    invoke-static {v0, v1, v2, v3}, Landroidx/core/content/ContextCompat;->registerReceiver(Landroid/content/Context;Landroid/content/BroadcastReceiver;Landroid/content/IntentFilter;I)Landroid/content/Intent;

    .line 104
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/rokid/phone/ai/AiVisionActivity;->receiverRegistered:Z

    .line 106
    :cond_0
    return-void
.end method
