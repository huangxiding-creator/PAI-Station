.class public final Lcom/rokid/security/phone/sdk/server/recog/offline/DownloadHelper;
.super Ljava/lang/Object;
.source "DownloadHelper.kt"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/rokid/security/phone/sdk/server/recog/offline/DownloadHelper$ProgressListener;
    }
.end annotation

.annotation system Ldalvik/annotation/SourceDebugExtension;
    value = "SMAP\nDownloadHelper.kt\nKotlin\n*S Kotlin\n*F\n+ 1 DownloadHelper.kt\ncom/rokid/security/phone/sdk/server/recog/offline/DownloadHelper\n+ 2 _Collections.kt\nkotlin/collections/CollectionsKt___CollectionsKt\n+ 3 fake.kt\nkotlin/jvm/internal/FakeKt\n*L\n1#1,204:1\n1855#2,2:205\n1855#2,2:208\n1#3:207\n*S KotlinDebug\n*F\n+ 1 DownloadHelper.kt\ncom/rokid/security/phone/sdk/server/recog/offline/DownloadHelper\n*L\n40#1:205,2\n164#1:208,2\n*E\n"
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000<\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\u0008\u0002\n\u0002\u0010\u000e\n\u0000\n\u0002\u0010#\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0003\n\u0002\u0010\u0002\n\u0002\u0008\u0003\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0010\u000b\n\u0002\u0008\u0004\u0008\u00c6\u0002\u0018\u00002\u00020\u0001:\u0001\u0017B\u0007\u0008\u0002\u00a2\u0006\u0002\u0010\u0002J\u001e\u0010\u000c\u001a\u00020\r2\u0006\u0010\u000e\u001a\u00020\u00042\u0006\u0010\u000f\u001a\u00020\u00042\u0006\u0010\u0010\u001a\u00020\u0011J-\u0010\u000c\u001a\u0004\u0018\u00010\u00042\u0006\u0010\u000e\u001a\u00020\u00042\u0006\u0010\u0012\u001a\u00020\u00042\u0008\u0008\u0002\u0010\u0013\u001a\u00020\u0014H\u0086@\u00f8\u0001\u0000\u00a2\u0006\u0002\u0010\u0015J$\u0010\u0016\u001a\u00020\r2\u0006\u0010\u000e\u001a\u00020\u00042\u0006\u0010\u0012\u001a\u00020\u00042\n\u0008\u0002\u0010\u0010\u001a\u0004\u0018\u00010\u0011H\u0002R\u000e\u0010\u0003\u001a\u00020\u0004X\u0082D\u00a2\u0006\u0002\n\u0000R\u0014\u0010\u0005\u001a\u0008\u0012\u0004\u0012\u00020\u00070\u0006X\u0082\u0004\u00a2\u0006\u0002\n\u0000R\u0011\u0010\u0008\u001a\u00020\t\u00a2\u0006\u0008\n\u0000\u001a\u0004\u0008\n\u0010\u000b\u0082\u0002\u0004\n\u0002\u0008\u0019\u00a8\u0006\u0018"
    }
    d2 = {
        "Lcom/rokid/security/phone/sdk/server/recog/offline/DownloadHelper;",
        "",
        "()V",
        "TAG",
        "",
        "downloadingSet",
        "",
        "Lokhttp3/HttpUrl;",
        "okHttpClient",
        "Lokhttp3/OkHttpClient;",
        "getOkHttpClient",
        "()Lokhttp3/OkHttpClient;",
        "download",
        "",
        "url",
        "filePath",
        "listener",
        "Lcom/rokid/security/phone/sdk/server/recog/offline/DownloadHelper$ProgressListener;",
        "path",
        "useOrigin",
        "",
        "(Ljava/lang/String;Ljava/lang/String;ZLkotlin/coroutines/Continuation;)Ljava/lang/Object;",
        "downloadWithHttp",
        "ProgressListener",
        "sdk-server_release"
    }
    k = 0x1
    mv = {
        0x1,
        0x8,
        0x0
    }
    xi = 0x30
.end annotation


# static fields
.field public static final INSTANCE:Lcom/rokid/security/phone/sdk/server/recog/offline/DownloadHelper;

.field private static final TAG:Ljava/lang/String;

.field private static final downloadingSet:Ljava/util/Set;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Set<",
            "Lokhttp3/HttpUrl;",
            ">;"
        }
    .end annotation
.end field

.field private static final okHttpClient:Lokhttp3/OkHttpClient;


# direct methods
.method public static synthetic $r8$lambda$EJvhSkgu_a8uoZx_qtRhe_pWn6I(Lkotlin/jvm/functions/Function2;Ljava/lang/Object;Ljava/lang/Object;)V
    .locals 0

    invoke-static {p0, p1, p2}, Lcom/rokid/security/phone/sdk/server/recog/offline/DownloadHelper;->downloadWithHttp$lambda$6(Lkotlin/jvm/functions/Function2;Ljava/lang/Object;Ljava/lang/Object;)V

    return-void
.end method

.method public static synthetic $r8$lambda$te8-fhsc4my9nnX0arihpwwCZMQ(Lkotlin/jvm/functions/Function2;Ljava/lang/Object;Ljava/lang/Object;)V
    .locals 0

    invoke-static {p0, p1, p2}, Lcom/rokid/security/phone/sdk/server/recog/offline/DownloadHelper;->download$lambda$2$lambda$1(Lkotlin/jvm/functions/Function2;Ljava/lang/Object;Ljava/lang/Object;)V

    return-void
.end method

.method static constructor <clinit>()V
    .locals 10

    new-instance v0, Lcom/rokid/security/phone/sdk/server/recog/offline/DownloadHelper;

    invoke-direct {v0}, Lcom/rokid/security/phone/sdk/server/recog/offline/DownloadHelper;-><init>()V

    sput-object v0, Lcom/rokid/security/phone/sdk/server/recog/offline/DownloadHelper;->INSTANCE:Lcom/rokid/security/phone/sdk/server/recog/offline/DownloadHelper;

    .line 25
    const-string v0, "DownloadHelper"

    sput-object v0, Lcom/rokid/security/phone/sdk/server/recog/offline/DownloadHelper;->TAG:Ljava/lang/String;

    .line 27
    nop

    .line 28
    sget-object v0, Ljava/util/concurrent/TimeUnit;->SECONDS:Ljava/util/concurrent/TimeUnit;

    const-wide/16 v1, 0x1e

    invoke-virtual {v0, v1, v2}, Ljava/util/concurrent/TimeUnit;->toMillis(J)J

    move-result-wide v3

    .line 29
    sget-object v0, Ljava/util/concurrent/TimeUnit;->SECONDS:Ljava/util/concurrent/TimeUnit;

    invoke-virtual {v0, v1, v2}, Ljava/util/concurrent/TimeUnit;->toMillis(J)J

    move-result-wide v5

    .line 27
    const/4 v8, 0x4

    const/4 v9, 0x0

    const/4 v7, 0x0

    invoke-static/range {v3 .. v9}, Lcom/rokid/security/phone/sdk/base/utils/net/utils/TrustAllHttp;->createOkHttpClient$default(JJLkotlin/jvm/functions/Function1;ILjava/lang/Object;)Lokhttp3/OkHttpClient;

    move-result-object v0

    sput-object v0, Lcom/rokid/security/phone/sdk/server/recog/offline/DownloadHelper;->okHttpClient:Lokhttp3/OkHttpClient;

    .line 32
    new-instance v0, Ljava/util/LinkedHashSet;

    invoke-direct {v0}, Ljava/util/LinkedHashSet;-><init>()V

    check-cast v0, Ljava/util/Set;

    sput-object v0, Lcom/rokid/security/phone/sdk/server/recog/offline/DownloadHelper;->downloadingSet:Ljava/util/Set;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 23
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static final synthetic access$getDownloadingSet$p()Ljava/util/Set;
    .locals 1

    .line 23
    sget-object v0, Lcom/rokid/security/phone/sdk/server/recog/offline/DownloadHelper;->downloadingSet:Ljava/util/Set;

    return-object v0
.end method

.method public static final synthetic access$getTAG$p()Ljava/lang/String;
    .locals 1

    .line 23
    sget-object v0, Lcom/rokid/security/phone/sdk/server/recog/offline/DownloadHelper;->TAG:Ljava/lang/String;

    return-object v0
.end method

.method public static synthetic download$default(Lcom/rokid/security/phone/sdk/server/recog/offline/DownloadHelper;Ljava/lang/String;Ljava/lang/String;ZLkotlin/coroutines/Continuation;ILjava/lang/Object;)Ljava/lang/Object;
    .locals 0

    .line 119
    and-int/lit8 p5, p5, 0x4

    if-eqz p5, :cond_0

    const/4 p3, 0x0

    :cond_0
    invoke-virtual {p0, p1, p2, p3, p4}, Lcom/rokid/security/phone/sdk/server/recog/offline/DownloadHelper;->download(Ljava/lang/String;Ljava/lang/String;ZLkotlin/coroutines/Continuation;)Ljava/lang/Object;

    move-result-object p0

    return-object p0
.end method

.method private static final download$lambda$2$lambda$1(Lkotlin/jvm/functions/Function2;Ljava/lang/Object;Ljava/lang/Object;)V
    .locals 1
    .param p0, "$tmp0"    # Lkotlin/jvm/functions/Function2;
    .param p1, "p0"    # Ljava/lang/Object;
    .param p2, "p1"    # Ljava/lang/Object;

    const-string v0, "$tmp0"

    invoke-static {p0, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 48
    invoke-interface {p0, p1, p2}, Lkotlin/jvm/functions/Function2;->invoke(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    return-void
.end method

.method private final downloadWithHttp(Ljava/lang/String;Ljava/lang/String;Lcom/rokid/security/phone/sdk/server/recog/offline/DownloadHelper$ProgressListener;)V
    .locals 15
    .param p1, "url"    # Ljava/lang/String;
    .param p2, "path"    # Ljava/lang/String;
    .param p3, "listener"    # Lcom/rokid/security/phone/sdk/server/recog/offline/DownloadHelper$ProgressListener;

    .line 159
    move-object/from16 v0, p1

    move-object/from16 v1, p3

    new-instance v2, Ljava/net/URL;

    invoke-direct {v2, v0}, Ljava/net/URL;-><init>(Ljava/lang/String;)V

    .line 160
    .local v2, "uri":Ljava/net/URL;
    invoke-static {v2}, Lcom/rokid/security/phone/sdk/base/utils/net/utils/TrustAllHttp;->openConnection(Ljava/net/URL;)Ljava/net/HttpURLConnection;

    move-result-object v3

    .line 161
    .local v3, "conn":Ljava/net/HttpURLConnection;
    const-string v4, "GET"

    invoke-virtual {v3, v4}, Ljava/net/HttpURLConnection;->setRequestMethod(Ljava/lang/String;)V

    .line 163
    nop

    .line 162
    sget-object v4, Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;->INSTANCE:Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;

    invoke-virtual {v4}, Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;->xAgentHeaderOrNull()Ljava/lang/String;

    move-result-object v4

    .line 163
    if-eqz v4, :cond_0

    .line 162
    nop

    .line 163
    nop

    .line 207
    .local v4, "it":Ljava/lang/String;
    const/4 v5, 0x0

    .line 163
    .local v5, "$i$a$-let-DownloadHelper$downloadWithHttp$1":I
    const-string v6, "X-Agent"

    invoke-virtual {v3, v6, v4}, Ljava/net/HttpURLConnection;->setRequestProperty(Ljava/lang/String;Ljava/lang/String;)V

    .line 164
    .end local v4    # "it":Ljava/lang/String;
    .end local v5    # "$i$a$-let-DownloadHelper$downloadWithHttp$1":I
    :cond_0
    sget-object v4, Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;->INSTANCE:Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;

    invoke-virtual {v4}, Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;->getResList()Ljava/util/List;

    move-result-object v4

    check-cast v4, Ljava/lang/Iterable;

    .local v4, "$this$forEach$iv":Ljava/lang/Iterable;
    const/4 v5, 0x0

    .line 208
    .local v5, "$i$f$forEach":I
    invoke-interface {v4}, Ljava/lang/Iterable;->iterator()Ljava/util/Iterator;

    move-result-object v6

    :goto_0
    invoke-interface {v6}, Ljava/util/Iterator;->hasNext()Z

    move-result v7

    const/4 v8, 0x0

    if-eqz v7, :cond_2

    invoke-interface {v6}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v7

    .local v7, "element$iv":Ljava/lang/Object;
    move-object v9, v7

    check-cast v9, Lcom/rokid/security/phone/sdk/base/data/ResItem;

    .local v9, "it":Lcom/rokid/security/phone/sdk/base/data/ResItem;
    const/4 v10, 0x0

    .line 165
    .local v10, "$i$a$-forEach-DownloadHelper$downloadWithHttp$2":I
    move-object v11, v0

    check-cast v11, Ljava/lang/CharSequence;

    invoke-virtual {v9}, Lcom/rokid/security/phone/sdk/base/data/ResItem;->getResourceAddress()Ljava/lang/String;

    move-result-object v12

    check-cast v12, Ljava/lang/CharSequence;

    const/4 v13, 0x2

    const/4 v14, 0x0

    invoke-static {v11, v12, v8, v13, v14}, Lkotlin/text/StringsKt;->contains$default(Ljava/lang/CharSequence;Ljava/lang/CharSequence;ZILjava/lang/Object;)Z

    move-result v8

    if-eqz v8, :cond_1

    .line 166
    const-string v8, "resId"

    invoke-virtual {v9}, Lcom/rokid/security/phone/sdk/base/data/ResItem;->getResId()Ljava/lang/String;

    move-result-object v11

    invoke-virtual {v3, v8, v11}, Ljava/net/HttpURLConnection;->setRequestProperty(Ljava/lang/String;Ljava/lang/String;)V

    .line 167
    const-string v8, "resOrgId"

    invoke-virtual {v9}, Lcom/rokid/security/phone/sdk/base/data/ResItem;->getResOrgId()Ljava/lang/String;

    move-result-object v11

    invoke-virtual {v3, v8, v11}, Ljava/net/HttpURLConnection;->setRequestProperty(Ljava/lang/String;Ljava/lang/String;)V

    .line 168
    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    const-string v11, "add headers [resId,"

    invoke-virtual {v8, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v9}, Lcom/rokid/security/phone/sdk/base/data/ResItem;->getResId()Ljava/lang/String;

    move-result-object v11

    invoke-virtual {v8, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    const-string v11, "]  \n  [resOrgId,"

    invoke-virtual {v8, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v9}, Lcom/rokid/security/phone/sdk/base/data/ResItem;->getResOrgId()Ljava/lang/String;

    move-result-object v11

    invoke-virtual {v8, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    const/16 v11, 0x5d

    invoke-virtual {v8, v11}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    filled-new-array {v8}, [Ljava/lang/Object;

    move-result-object v8

    const-string v11, "download"

    invoke-static {v11, v8}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 170
    :cond_1
    nop

    .line 208
    .end local v9    # "it":Lcom/rokid/security/phone/sdk/base/data/ResItem;
    .end local v10    # "$i$a$-forEach-DownloadHelper$downloadWithHttp$2":I
    nop

    .end local v7    # "element$iv":Ljava/lang/Object;
    goto :goto_0

    .line 209
    :cond_2
    nop

    .line 171
    .end local v4    # "$this$forEach$iv":Ljava/lang/Iterable;
    .end local v5    # "$i$f$forEach":I
    sget-object v4, Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;->INSTANCE:Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;

    invoke-virtual {v4}, Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;->getHeaders()Ljava/util/concurrent/ConcurrentHashMap;

    move-result-object v4

    new-instance v5, Lcom/rokid/security/phone/sdk/server/recog/offline/DownloadHelper$downloadWithHttp$3;

    invoke-direct {v5, v3}, Lcom/rokid/security/phone/sdk/server/recog/offline/DownloadHelper$downloadWithHttp$3;-><init>(Ljava/net/HttpURLConnection;)V

    check-cast v5, Lkotlin/jvm/functions/Function2;

    new-instance v6, Lcom/rokid/security/phone/sdk/server/recog/offline/DownloadHelper$$ExternalSyntheticLambda0;

    invoke-direct {v6, v5}, Lcom/rokid/security/phone/sdk/server/recog/offline/DownloadHelper$$ExternalSyntheticLambda0;-><init>(Lkotlin/jvm/functions/Function2;)V

    invoke-virtual {v4, v6}, Ljava/util/concurrent/ConcurrentHashMap;->forEach(Ljava/util/function/BiConsumer;)V

    .line 174
    invoke-virtual {v3}, Ljava/net/HttpURLConnection;->connect()V

    .line 175
    invoke-virtual {v3}, Ljava/net/HttpURLConnection;->getResponseCode()I

    move-result v4

    .line 176
    .local v4, "code":I
    const/16 v5, 0x800

    new-array v6, v5, [B

    .line 177
    .local v6, "buf":[B
    const/16 v7, 0xc8

    if-ne v4, v7, :cond_4

    .line 178
    invoke-virtual {v3}, Ljava/net/HttpURLConnection;->getInputStream()Ljava/io/InputStream;

    move-result-object v7

    .line 179
    .local v7, "inputStream":Ljava/io/InputStream;
    new-instance v9, Ljava/io/FileOutputStream;

    new-instance v10, Ljava/io/File;

    move-object/from16 v11, p2

    invoke-direct {v10, v11}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-direct {v9, v10}, Ljava/io/FileOutputStream;-><init>(Ljava/io/File;)V

    .line 180
    .local v9, "fos":Ljava/io/FileOutputStream;
    const/4 v10, 0x0

    .line 181
    .local v10, "len":I
    :goto_1
    nop

    .line 182
    nop

    .line 181
    invoke-virtual {v7, v6, v8, v5}, Ljava/io/InputStream;->read([BII)I

    move-result v12

    .line 183
    move v13, v12

    .line 207
    .local v13, "it":I
    const/4 v14, 0x0

    .line 183
    .local v14, "$i$a$-also-DownloadHelper$downloadWithHttp$4":I
    move v10, v13

    .end local v13    # "it":I
    .end local v14    # "$i$a$-also-DownloadHelper$downloadWithHttp$4":I
    const/4 v13, -0x1

    if-eq v12, v13, :cond_3

    .line 185
    invoke-virtual {v9, v6, v8, v10}, Ljava/io/FileOutputStream;->write([BII)V

    goto :goto_1

    .line 187
    :cond_3
    invoke-virtual {v9}, Ljava/io/FileOutputStream;->flush()V

    .line 188
    if-eqz v1, :cond_5

    invoke-interface/range {p3 .. p3}, Lcom/rokid/security/phone/sdk/server/recog/offline/DownloadHelper$ProgressListener;->onComplete()V

    goto :goto_2

    .line 190
    .end local v7    # "inputStream":Ljava/io/InputStream;
    .end local v9    # "fos":Ljava/io/FileOutputStream;
    .end local v10    # "len":I
    :cond_4
    move-object/from16 v11, p2

    if-eqz v1, :cond_5

    new-instance v5, Ljava/lang/Exception;

    const-string v7, "network error"

    invoke-direct {v5, v7}, Ljava/lang/Exception;-><init>(Ljava/lang/String;)V

    invoke-interface {v1, v5}, Lcom/rokid/security/phone/sdk/server/recog/offline/DownloadHelper$ProgressListener;->onError(Ljava/lang/Exception;)V

    .line 192
    :cond_5
    :goto_2
    return-void
.end method

.method static synthetic downloadWithHttp$default(Lcom/rokid/security/phone/sdk/server/recog/offline/DownloadHelper;Ljava/lang/String;Ljava/lang/String;Lcom/rokid/security/phone/sdk/server/recog/offline/DownloadHelper$ProgressListener;ILjava/lang/Object;)V
    .locals 0

    .line 158
    and-int/lit8 p4, p4, 0x4

    if-eqz p4, :cond_0

    const/4 p3, 0x0

    :cond_0
    invoke-direct {p0, p1, p2, p3}, Lcom/rokid/security/phone/sdk/server/recog/offline/DownloadHelper;->downloadWithHttp(Ljava/lang/String;Ljava/lang/String;Lcom/rokid/security/phone/sdk/server/recog/offline/DownloadHelper$ProgressListener;)V

    return-void
.end method

.method private static final downloadWithHttp$lambda$6(Lkotlin/jvm/functions/Function2;Ljava/lang/Object;Ljava/lang/Object;)V
    .locals 1
    .param p0, "$tmp0"    # Lkotlin/jvm/functions/Function2;
    .param p1, "p0"    # Ljava/lang/Object;
    .param p2, "p1"    # Ljava/lang/Object;

    const-string v0, "$tmp0"

    invoke-static {p0, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 171
    invoke-interface {p0, p1, p2}, Lkotlin/jvm/functions/Function2;->invoke(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    return-void
.end method


# virtual methods
.method public final download(Ljava/lang/String;Ljava/lang/String;ZLkotlin/coroutines/Continuation;)Ljava/lang/Object;
    .locals 6
    .param p1, "url"    # Ljava/lang/String;
    .param p2, "path"    # Ljava/lang/String;
    .param p3, "useOrigin"    # Z
    .param p4, "$completion"    # Lkotlin/coroutines/Continuation;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Z",
            "Lkotlin/coroutines/Continuation<",
            "-",
            "Ljava/lang/String;",
            ">;)",
            "Ljava/lang/Object;"
        }
    .end annotation

    .line 120
    new-instance v0, Lkotlin/coroutines/SafeContinuation;

    invoke-static {p4}, Lkotlin/coroutines/intrinsics/IntrinsicsKt;->intercepted(Lkotlin/coroutines/Continuation;)Lkotlin/coroutines/Continuation;

    move-result-object v1

    invoke-direct {v0, v1}, Lkotlin/coroutines/SafeContinuation;-><init>(Lkotlin/coroutines/Continuation;)V

    move-object v1, v0

    check-cast v1, Lkotlin/coroutines/Continuation;

    .local v1, "continuation":Lkotlin/coroutines/Continuation;
    const/4 v2, 0x0

    .line 121
    .local v2, "$i$a$-suspendCoroutine-DownloadHelper$download$3":I
    sget-object v3, Lcom/rokid/security/phone/sdk/server/recog/offline/DownloadHelper;->TAG:Ljava/lang/String;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v5, "\u6587\u6863\u4e0b\u8f7d\uff1a"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    filled-new-array {v4}, [Ljava/lang/Object;

    move-result-object v4

    invoke-static {v3, v4}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 122
    if-eqz p3, :cond_0

    .line 123
    sget-object v3, Lcom/rokid/security/phone/sdk/server/recog/offline/DownloadHelper;->INSTANCE:Lcom/rokid/security/phone/sdk/server/recog/offline/DownloadHelper;

    new-instance v4, Lcom/rokid/security/phone/sdk/server/recog/offline/DownloadHelper$download$3$1;

    invoke-direct {v4, v1, p2}, Lcom/rokid/security/phone/sdk/server/recog/offline/DownloadHelper$download$3$1;-><init>(Lkotlin/coroutines/Continuation;Ljava/lang/String;)V

    check-cast v4, Lcom/rokid/security/phone/sdk/server/recog/offline/DownloadHelper$ProgressListener;

    invoke-direct {v3, p1, p2, v4}, Lcom/rokid/security/phone/sdk/server/recog/offline/DownloadHelper;->downloadWithHttp(Ljava/lang/String;Ljava/lang/String;Lcom/rokid/security/phone/sdk/server/recog/offline/DownloadHelper$ProgressListener;)V

    goto :goto_0

    .line 139
    :cond_0
    sget-object v3, Lcom/rokid/security/phone/sdk/server/recog/offline/DownloadHelper;->INSTANCE:Lcom/rokid/security/phone/sdk/server/recog/offline/DownloadHelper;

    new-instance v4, Lcom/rokid/security/phone/sdk/server/recog/offline/DownloadHelper$download$3$2;

    invoke-direct {v4, v1, p2}, Lcom/rokid/security/phone/sdk/server/recog/offline/DownloadHelper$download$3$2;-><init>(Lkotlin/coroutines/Continuation;Ljava/lang/String;)V

    check-cast v4, Lcom/rokid/security/phone/sdk/server/recog/offline/DownloadHelper$ProgressListener;

    invoke-virtual {v3, p1, p2, v4}, Lcom/rokid/security/phone/sdk/server/recog/offline/DownloadHelper;->download(Ljava/lang/String;Ljava/lang/String;Lcom/rokid/security/phone/sdk/server/recog/offline/DownloadHelper$ProgressListener;)V

    .line 155
    :goto_0
    nop

    .line 120
    .end local v1    # "continuation":Lkotlin/coroutines/Continuation;
    .end local v2    # "$i$a$-suspendCoroutine-DownloadHelper$download$3":I
    invoke-virtual {v0}, Lkotlin/coroutines/SafeContinuation;->getOrThrow()Ljava/lang/Object;

    move-result-object v0

    invoke-static {}, Lkotlin/coroutines/intrinsics/IntrinsicsKt;->getCOROUTINE_SUSPENDED()Ljava/lang/Object;

    move-result-object v1

    if-ne v0, v1, :cond_1

    invoke-static {p4}, Lkotlin/coroutines/jvm/internal/DebugProbesKt;->probeCoroutineSuspended(Lkotlin/coroutines/Continuation;)V

    .line 155
    :cond_1
    return-object v0
.end method

.method public final declared-synchronized download(Ljava/lang/String;Ljava/lang/String;Lcom/rokid/security/phone/sdk/server/recog/offline/DownloadHelper$ProgressListener;)V
    .locals 17
    .param p1, "url"    # Ljava/lang/String;
    .param p2, "filePath"    # Ljava/lang/String;
    .param p3, "listener"    # Lcom/rokid/security/phone/sdk/server/recog/offline/DownloadHelper$ProgressListener;

    move-object/from16 v0, p1

    move-object/from16 v1, p2

    move-object/from16 v2, p3

    monitor-enter p0

    :try_start_0
    const-string/jumbo v3, "url"

    invoke-static {v0, v3}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v3, "filePath"

    invoke-static {v1, v3}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v3, "listener"

    invoke-static {v2, v3}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 36
    sget-object v3, Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;->INSTANCE:Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;

    invoke-virtual {v3}, Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;->ensureBusinessHeaders()V

    .line 37
    new-instance v3, Lokhttp3/Request$Builder;

    invoke-direct {v3}, Lokhttp3/Request$Builder;-><init>()V

    .line 38
    invoke-virtual {v3, v0}, Lokhttp3/Request$Builder;->url(Ljava/lang/String;)Lokhttp3/Request$Builder;

    move-result-object v3

    .line 39
    move-object v4, v3

    .local v4, "$this$download_u24lambda_u242":Lokhttp3/Request$Builder;
    const/4 v5, 0x0

    .line 40
    .local v5, "$i$a$-apply-DownloadHelper$download$request$1":I
    sget-object v6, Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;->INSTANCE:Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;

    invoke-virtual {v6}, Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;->getResList()Ljava/util/List;

    move-result-object v6

    check-cast v6, Ljava/lang/Iterable;

    .local v6, "$this$forEach$iv":Ljava/lang/Iterable;
    const/4 v7, 0x0

    .line 205
    .local v7, "$i$f$forEach":I
    invoke-interface {v6}, Ljava/lang/Iterable;->iterator()Ljava/util/Iterator;

    move-result-object v8

    :goto_0
    invoke-interface {v8}, Ljava/util/Iterator;->hasNext()Z

    move-result v9

    if-eqz v9, :cond_1

    invoke-interface {v8}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v9

    .local v9, "element$iv":Ljava/lang/Object;
    move-object v10, v9

    check-cast v10, Lcom/rokid/security/phone/sdk/base/data/ResItem;

    .local v10, "it":Lcom/rokid/security/phone/sdk/base/data/ResItem;
    const/4 v11, 0x0

    .line 41
    .local v11, "$i$a$-forEach-DownloadHelper$download$request$1$1":I
    move-object v12, v0

    check-cast v12, Ljava/lang/CharSequence;

    invoke-virtual {v10}, Lcom/rokid/security/phone/sdk/base/data/ResItem;->getResourceAddress()Ljava/lang/String;

    move-result-object v13

    check-cast v13, Ljava/lang/CharSequence;

    const/4 v14, 0x2

    const/4 v15, 0x0

    move/from16 v16, v5

    .end local v5    # "$i$a$-apply-DownloadHelper$download$request$1":I
    .local v16, "$i$a$-apply-DownloadHelper$download$request$1":I
    const/4 v5, 0x0

    invoke-static {v12, v13, v5, v14, v15}, Lkotlin/text/StringsKt;->contains$default(Ljava/lang/CharSequence;Ljava/lang/CharSequence;ZILjava/lang/Object;)Z

    move-result v5

    if-eqz v5, :cond_0

    .line 42
    const-string v5, "resId"

    invoke-virtual {v10}, Lcom/rokid/security/phone/sdk/base/data/ResItem;->getResId()Ljava/lang/String;

    move-result-object v12

    invoke-virtual {v4, v5, v12}, Lokhttp3/Request$Builder;->header(Ljava/lang/String;Ljava/lang/String;)Lokhttp3/Request$Builder;

    .line 43
    const-string v5, "resOrgId"

    invoke-virtual {v10}, Lcom/rokid/security/phone/sdk/base/data/ResItem;->getResOrgId()Ljava/lang/String;

    move-result-object v12

    invoke-virtual {v4, v5, v12}, Lokhttp3/Request$Builder;->header(Ljava/lang/String;Ljava/lang/String;)Lokhttp3/Request$Builder;

    .line 44
    const-string v5, "download"

    new-instance v12, Ljava/lang/StringBuilder;

    invoke-direct {v12}, Ljava/lang/StringBuilder;-><init>()V

    const-string v13, "add headers [resId,"

    invoke-virtual {v12, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v12

    invoke-virtual {v10}, Lcom/rokid/security/phone/sdk/base/data/ResItem;->getResId()Ljava/lang/String;

    move-result-object v13

    invoke-virtual {v12, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v12

    const-string v13, "] "

    invoke-virtual {v12, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v12

    invoke-virtual {v12}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v12

    filled-new-array {v12}, [Ljava/lang/Object;

    move-result-object v12

    invoke-static {v5, v12}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 45
    const-string v5, "download"

    new-instance v12, Ljava/lang/StringBuilder;

    invoke-direct {v12}, Ljava/lang/StringBuilder;-><init>()V

    const-string v13, "add headers [resOrgId,"

    invoke-virtual {v12, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v12

    invoke-virtual {v10}, Lcom/rokid/security/phone/sdk/base/data/ResItem;->getResOrgId()Ljava/lang/String;

    move-result-object v13

    invoke-virtual {v12, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v12

    const-string v13, "] "

    invoke-virtual {v12, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v12

    invoke-virtual {v12}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v12

    filled-new-array {v12}, [Ljava/lang/Object;

    move-result-object v12

    invoke-static {v5, v12}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 47
    .end local p0    # "this":Lcom/rokid/security/phone/sdk/server/recog/offline/DownloadHelper;
    :cond_0
    nop

    .line 205
    .end local v10    # "it":Lcom/rokid/security/phone/sdk/base/data/ResItem;
    .end local v11    # "$i$a$-forEach-DownloadHelper$download$request$1$1":I
    move/from16 v5, v16

    .end local v9    # "element$iv":Ljava/lang/Object;
    goto/16 :goto_0

    .line 206
    .end local v16    # "$i$a$-apply-DownloadHelper$download$request$1":I
    .restart local v5    # "$i$a$-apply-DownloadHelper$download$request$1":I
    :cond_1
    move/from16 v16, v5

    .line 48
    .end local v5    # "$i$a$-apply-DownloadHelper$download$request$1":I
    .end local v6    # "$this$forEach$iv":Ljava/lang/Iterable;
    .end local v7    # "$i$f$forEach":I
    .restart local v16    # "$i$a$-apply-DownloadHelper$download$request$1":I
    sget-object v5, Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;->INSTANCE:Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;

    invoke-virtual {v5}, Lcom/rokid/security/sdk/ability/net/SecuritySDKEnv;->getHeaders()Ljava/util/concurrent/ConcurrentHashMap;

    move-result-object v5

    new-instance v6, Lcom/rokid/security/phone/sdk/server/recog/offline/DownloadHelper$download$request$1$2;

    invoke-direct {v6, v4}, Lcom/rokid/security/phone/sdk/server/recog/offline/DownloadHelper$download$request$1$2;-><init>(Lokhttp3/Request$Builder;)V

    check-cast v6, Lkotlin/jvm/functions/Function2;

    new-instance v7, Lcom/rokid/security/phone/sdk/server/recog/offline/DownloadHelper$$ExternalSyntheticLambda1;

    invoke-direct {v7, v6}, Lcom/rokid/security/phone/sdk/server/recog/offline/DownloadHelper$$ExternalSyntheticLambda1;-><init>(Lkotlin/jvm/functions/Function2;)V

    invoke-virtual {v5, v7}, Ljava/util/concurrent/ConcurrentHashMap;->forEach(Ljava/util/function/BiConsumer;)V

    .line 52
    nop

    .line 39
    .end local v4    # "$this$download_u24lambda_u242":Lokhttp3/Request$Builder;
    .end local v16    # "$i$a$-apply-DownloadHelper$download$request$1":I
    nop

    .line 53
    invoke-virtual {v3}, Lokhttp3/Request$Builder;->get()Lokhttp3/Request$Builder;

    move-result-object v3

    .line 54
    invoke-virtual {v3}, Lokhttp3/Request$Builder;->build()Lokhttp3/Request;

    move-result-object v3

    .line 37
    nop

    .line 57
    .local v3, "request":Lokhttp3/Request;
    sget-object v4, Lcom/rokid/security/phone/sdk/server/recog/offline/DownloadHelper;->downloadingSet:Ljava/util/Set;

    invoke-virtual {v3}, Lokhttp3/Request;->url()Lokhttp3/HttpUrl;

    move-result-object v5

    invoke-interface {v4, v5}, Ljava/util/Set;->contains(Ljava/lang/Object;)Z

    move-result v4
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-eqz v4, :cond_2

    .line 58
    monitor-exit p0

    return-void

    .line 60
    :cond_2
    :try_start_1
    sget-object v4, Lcom/rokid/security/phone/sdk/server/recog/offline/DownloadHelper;->downloadingSet:Ljava/util/Set;

    invoke-virtual {v3}, Lokhttp3/Request;->url()Lokhttp3/HttpUrl;

    move-result-object v5

    const-string v6, "request.url()"

    invoke-static {v5, v6}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-interface {v4, v5}, Ljava/util/Set;->add(Ljava/lang/Object;)Z

    .line 61
    invoke-interface/range {p3 .. p3}, Lcom/rokid/security/phone/sdk/server/recog/offline/DownloadHelper$ProgressListener;->onStart()V

    .line 63
    sget-object v4, Lcom/rokid/security/phone/sdk/server/recog/offline/DownloadHelper;->TAG:Ljava/lang/String;

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v6, "\u5f00\u59cb\u4e0b\u8f7d\uff1arequest = "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    filled-new-array {v5}, [Ljava/lang/Object;

    move-result-object v5

    invoke-static {v4, v5}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 64
    sget-object v4, Lcom/rokid/security/phone/sdk/server/recog/offline/DownloadHelper;->okHttpClient:Lokhttp3/OkHttpClient;

    invoke-virtual {v4, v3}, Lokhttp3/OkHttpClient;->newCall(Lokhttp3/Request;)Lokhttp3/Call;

    move-result-object v4

    new-instance v5, Lcom/rokid/security/phone/sdk/server/recog/offline/DownloadHelper$download$1;

    invoke-direct {v5, v2, v3, v1, v0}, Lcom/rokid/security/phone/sdk/server/recog/offline/DownloadHelper$download$1;-><init>(Lcom/rokid/security/phone/sdk/server/recog/offline/DownloadHelper$ProgressListener;Lokhttp3/Request;Ljava/lang/String;Ljava/lang/String;)V

    check-cast v5, Lokhttp3/Callback;

    invoke-interface {v4, v5}, Lokhttp3/Call;->enqueue(Lokhttp3/Callback;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 117
    monitor-exit p0

    return-void

    .line 35
    .end local v3    # "request":Lokhttp3/Request;
    .end local p1    # "url":Ljava/lang/String;
    .end local p2    # "filePath":Ljava/lang/String;
    .end local p3    # "listener":Lcom/rokid/security/phone/sdk/server/recog/offline/DownloadHelper$ProgressListener;
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method public final getOkHttpClient()Lokhttp3/OkHttpClient;
    .locals 1

    .line 27
    sget-object v0, Lcom/rokid/security/phone/sdk/server/recog/offline/DownloadHelper;->okHttpClient:Lokhttp3/OkHttpClient;

    return-object v0
.end method
