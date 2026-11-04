.class public final Lcom/rokid/security/phone/sdk/server/blutooth/ring/RingDeviceClassifier;
.super Ljava/lang/Object;
.source "RingDeviceClassifier.kt"


# annotations
.annotation system Ldalvik/annotation/SourceDebugExtension;
    value = "SMAP\nRingDeviceClassifier.kt\nKotlin\n*S Kotlin\n*F\n+ 1 RingDeviceClassifier.kt\ncom/rokid/security/phone/sdk/server/blutooth/ring/RingDeviceClassifier\n+ 2 _Collections.kt\nkotlin/collections/CollectionsKt___CollectionsKt\n+ 3 ArraysJVM.kt\nkotlin/collections/ArraysKt__ArraysJVMKt\n+ 4 ArrayIntrinsics.kt\nkotlin/ArrayIntrinsicsKt\n+ 5 _Arrays.kt\nkotlin/collections/ArraysKt___ArraysKt\n*L\n1#1,37:1\n1747#2,3:38\n1747#2,3:46\n18#3:41\n26#4:42\n11670#5,3:43\n*S KotlinDebug\n*F\n+ 1 RingDeviceClassifier.kt\ncom/rokid/security/phone/sdk/server/blutooth/ring/RingDeviceClassifier\n*L\n18#1:38,3\n35#1:46,3\n23#1:41\n23#1:42\n23#1:43,3\n*E\n"
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u00004\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\u0008\u0002\n\u0002\u0010\u000e\n\u0002\u0008\u0002\n\u0002\u0010\u000b\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010 \n\u0000\n\u0002\u0010\u0008\n\u0000\n\u0002\u0010\"\n\u0002\u0008\u0004\u0008\u00c0\u0002\u0018\u00002\u00020\u0001B\u0007\u0008\u0002\u00a2\u0006\u0002\u0010\u0002J\u001e\u0010\u0006\u001a\u00020\u00072\u0006\u0010\u0008\u001a\u00020\t2\u000c\u0010\n\u001a\u0008\u0012\u0004\u0012\u00020\u00040\u000bH\u0007J/\u0010\u0006\u001a\u00020\u00072\u0008\u0010\u000c\u001a\u0004\u0018\u00010\r2\u000c\u0010\u000e\u001a\u0008\u0012\u0004\u0012\u00020\u00040\u000f2\u0006\u0010\u0010\u001a\u00020\u0007H\u0000\u00a2\u0006\u0004\u0008\u0011\u0010\u0012R\u000e\u0010\u0003\u001a\u00020\u0004X\u0082T\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0005\u001a\u00020\u0004X\u0082T\u00a2\u0006\u0002\n\u0000\u00a8\u0006\u0013"
    }
    d2 = {
        "Lcom/rokid/security/phone/sdk/server/blutooth/ring/RingDeviceClassifier;",
        "",
        "()V",
        "HID_UUID",
        "",
        "HOGP_UUID",
        "isCandidate",
        "",
        "device",
        "Landroid/bluetooth/BluetoothDevice;",
        "trustedNamePrefixes",
        "",
        "majorDeviceClass",
        "",
        "serviceUuids",
        "",
        "trustedName",
        "isCandidate$sdk_server_release",
        "(Ljava/lang/Integer;Ljava/util/Set;Z)Z",
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
.field private static final HID_UUID:Ljava/lang/String; = "00001124-0000-1000-8000-00805f9b34fb"

.field private static final HOGP_UUID:Ljava/lang/String; = "00001812-0000-1000-8000-00805f9b34fb"

.field public static final INSTANCE:Lcom/rokid/security/phone/sdk/server/blutooth/ring/RingDeviceClassifier;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    new-instance v0, Lcom/rokid/security/phone/sdk/server/blutooth/ring/RingDeviceClassifier;

    invoke-direct {v0}, Lcom/rokid/security/phone/sdk/server/blutooth/ring/RingDeviceClassifier;-><init>()V

    sput-object v0, Lcom/rokid/security/phone/sdk/server/blutooth/ring/RingDeviceClassifier;->INSTANCE:Lcom/rokid/security/phone/sdk/server/blutooth/ring/RingDeviceClassifier;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 11
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public final isCandidate(Landroid/bluetooth/BluetoothDevice;Ljava/util/List;)Z
    .locals 12
    .param p1, "device"    # Landroid/bluetooth/BluetoothDevice;
    .param p2, "trustedNamePrefixes"    # Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/bluetooth/BluetoothDevice;",
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;)Z"
        }
    .end annotation

    const-string v0, "device"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string/jumbo v0, "trustedNamePrefixes"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 17
    invoke-virtual {p1}, Landroid/bluetooth/BluetoothDevice;->getName()Ljava/lang/String;

    move-result-object v0

    const/4 v1, 0x0

    if-eqz v0, :cond_5

    .local v0, "name":Ljava/lang/String;
    const/4 v2, 0x0

    .line 18
    .local v2, "$i$a$-let-RingDeviceClassifier$isCandidate$trustedName$1":I
    move-object v3, p2

    check-cast v3, Ljava/lang/Iterable;

    .local v3, "$this$any$iv":Ljava/lang/Iterable;
    const/4 v4, 0x0

    .line 38
    .local v4, "$i$f$any":I
    instance-of v5, v3, Ljava/util/Collection;

    const/4 v6, 0x1

    if-eqz v5, :cond_0

    move-object v5, v3

    check-cast v5, Ljava/util/Collection;

    invoke-interface {v5}, Ljava/util/Collection;->isEmpty()Z

    move-result v5

    if-eqz v5, :cond_0

    move v3, v1

    goto :goto_1

    .line 39
    :cond_0
    invoke-interface {v3}, Ljava/lang/Iterable;->iterator()Ljava/util/Iterator;

    move-result-object v5

    :cond_1
    invoke-interface {v5}, Ljava/util/Iterator;->hasNext()Z

    move-result v7

    if-eqz v7, :cond_3

    invoke-interface {v5}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v7

    .local v7, "element$iv":Ljava/lang/Object;
    move-object v8, v7

    check-cast v8, Ljava/lang/String;

    .local v8, "prefix":Ljava/lang/String;
    const/4 v9, 0x0

    .line 19
    .local v9, "$i$a$-any-RingDeviceClassifier$isCandidate$trustedName$1$1":I
    move-object v10, v8

    check-cast v10, Ljava/lang/CharSequence;

    invoke-static {v10}, Lkotlin/text/StringsKt;->isBlank(Ljava/lang/CharSequence;)Z

    move-result v10

    xor-int/2addr v10, v6

    if-eqz v10, :cond_2

    move-object v10, v0

    check-cast v10, Ljava/lang/CharSequence;

    move-object v11, v8

    check-cast v11, Ljava/lang/CharSequence;

    invoke-static {v10, v11, v6}, Lkotlin/text/StringsKt;->contains(Ljava/lang/CharSequence;Ljava/lang/CharSequence;Z)Z

    move-result v10

    if-eqz v10, :cond_2

    move v8, v6

    goto :goto_0

    :cond_2
    move v8, v1

    .line 39
    .end local v8    # "prefix":Ljava/lang/String;
    .end local v9    # "$i$a$-any-RingDeviceClassifier$isCandidate$trustedName$1$1":I
    :goto_0
    if-eqz v8, :cond_1

    move v3, v6

    goto :goto_1

    .line 40
    .end local v7    # "element$iv":Ljava/lang/Object;
    :cond_3
    move v3, v1

    .line 18
    .end local v3    # "$this$any$iv":Ljava/lang/Iterable;
    .end local v4    # "$i$f$any":I
    :goto_1
    nop

    .line 17
    .end local v0    # "name":Ljava/lang/String;
    .end local v2    # "$i$a$-let-RingDeviceClassifier$isCandidate$trustedName$1":I
    nop

    .line 21
    if-ne v3, v6, :cond_4

    goto :goto_2

    :cond_4
    move v6, v1

    goto :goto_2

    .line 17
    :cond_5
    move v6, v1

    :goto_2
    move v0, v6

    .line 22
    .local v0, "trustedName":Z
    invoke-virtual {p1}, Landroid/bluetooth/BluetoothDevice;->getBluetoothClass()Landroid/bluetooth/BluetoothClass;

    move-result-object v2

    if-eqz v2, :cond_6

    invoke-virtual {v2}, Landroid/bluetooth/BluetoothClass;->getMajorDeviceClass()I

    move-result v2

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    goto :goto_3

    :cond_6
    const/4 v2, 0x0

    .line 23
    .local v2, "majorDeviceClass":Ljava/lang/Integer;
    :goto_3
    invoke-virtual {p1}, Landroid/bluetooth/BluetoothDevice;->getUuids()[Landroid/os/ParcelUuid;

    move-result-object v3

    .local v3, "$this$orEmpty$iv":[Ljava/lang/Object;
    const/4 v4, 0x0

    .line 41
    .local v4, "$i$f$orEmpty":I
    if-nez v3, :cond_7

    const/4 v5, 0x0

    .line 42
    .local v5, "$i$f$emptyArray":I
    new-array v6, v1, [Landroid/os/ParcelUuid;

    goto :goto_4

    .line 41
    .end local v5    # "$i$f$emptyArray":I
    :cond_7
    move-object v6, v3

    :goto_4
    nop

    .line 23
    .end local v3    # "$this$orEmpty$iv":[Ljava/lang/Object;
    .end local v4    # "$i$f$orEmpty":I
    new-instance v3, Ljava/util/LinkedHashSet;

    invoke-direct {v3}, Ljava/util/LinkedHashSet;-><init>()V

    check-cast v3, Ljava/util/Set;

    check-cast v3, Ljava/util/Collection;

    .local v3, "destination$iv":Ljava/util/Collection;
    move-object v4, v6

    .local v4, "$this$mapTo$iv":[Ljava/lang/Object;
    const/4 v5, 0x0

    .line 43
    .local v5, "$i$f$mapTo":I
    array-length v6, v4

    :goto_5
    if-ge v1, v6, :cond_8

    aget-object v7, v4, v1

    .line 44
    .local v7, "item$iv":Ljava/lang/Object;
    move-object v8, v7

    .local v8, "it":Landroid/os/ParcelUuid;
    const/4 v9, 0x0

    .line 24
    .local v9, "$i$a$-mapTo-RingDeviceClassifier$isCandidate$serviceUuids$1":I
    invoke-virtual {v8}, Landroid/os/ParcelUuid;->getUuid()Ljava/util/UUID;

    move-result-object v10

    invoke-virtual {v10}, Ljava/util/UUID;->toString()Ljava/lang/String;

    move-result-object v10

    const-string v11, "it.uuid.toString()"

    invoke-static {v10, v11}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    sget-object v11, Ljava/util/Locale;->ROOT:Ljava/util/Locale;

    invoke-virtual {v10, v11}, Ljava/lang/String;->toLowerCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v10

    const-string/jumbo v11, "this as java.lang.String).toLowerCase(Locale.ROOT)"

    invoke-static {v10, v11}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    .line 44
    .end local v8    # "it":Landroid/os/ParcelUuid;
    .end local v9    # "$i$a$-mapTo-RingDeviceClassifier$isCandidate$serviceUuids$1":I
    invoke-interface {v3, v10}, Ljava/util/Collection;->add(Ljava/lang/Object;)Z

    .line 43
    .end local v7    # "item$iv":Ljava/lang/Object;
    add-int/lit8 v1, v1, 0x1

    goto :goto_5

    .line 45
    :cond_8
    nop

    .line 23
    .end local v3    # "destination$iv":Ljava/util/Collection;
    .end local v4    # "$this$mapTo$iv":[Ljava/lang/Object;
    .end local v5    # "$i$f$mapTo":I
    move-object v1, v3

    check-cast v1, Ljava/util/Set;

    .line 26
    .local v1, "serviceUuids":Ljava/util/Set;
    invoke-virtual {p0, v2, v1, v0}, Lcom/rokid/security/phone/sdk/server/blutooth/ring/RingDeviceClassifier;->isCandidate$sdk_server_release(Ljava/lang/Integer;Ljava/util/Set;Z)Z

    move-result v3

    return v3
.end method

.method public final isCandidate$sdk_server_release(Ljava/lang/Integer;Ljava/util/Set;Z)Z
    .locals 9
    .param p1, "majorDeviceClass"    # Ljava/lang/Integer;
    .param p2, "serviceUuids"    # Ljava/util/Set;
    .param p3, "trustedName"    # Z
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/Integer;",
            "Ljava/util/Set<",
            "Ljava/lang/String;",
            ">;Z)Z"
        }
    .end annotation

    const-string/jumbo v0, "serviceUuids"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 33
    const/4 v0, 0x1

    if-nez p3, :cond_7

    .line 34
    if-nez p1, :cond_0

    goto :goto_0

    :cond_0
    invoke-virtual {p1}, Ljava/lang/Integer;->intValue()I

    move-result v1

    const/16 v2, 0x500

    if-eq v1, v2, :cond_7

    .line 35
    :goto_0
    move-object v1, p2

    check-cast v1, Ljava/lang/Iterable;

    .local v1, "$this$any$iv":Ljava/lang/Iterable;
    const/4 v2, 0x0

    .line 46
    .local v2, "$i$f$any":I
    instance-of v3, v1, Ljava/util/Collection;

    const/4 v4, 0x0

    if-eqz v3, :cond_1

    move-object v3, v1

    check-cast v3, Ljava/util/Collection;

    invoke-interface {v3}, Ljava/util/Collection;->isEmpty()Z

    move-result v3

    if-eqz v3, :cond_1

    move v1, v4

    goto :goto_3

    .line 47
    :cond_1
    invoke-interface {v1}, Ljava/lang/Iterable;->iterator()Ljava/util/Iterator;

    move-result-object v3

    :cond_2
    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z

    move-result v5

    if-eqz v5, :cond_5

    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v5

    .local v5, "element$iv":Ljava/lang/Object;
    move-object v6, v5

    check-cast v6, Ljava/lang/String;

    .local v6, "it":Ljava/lang/String;
    const/4 v7, 0x0

    .line 35
    .local v7, "$i$a$-any-RingDeviceClassifier$isCandidate$1":I
    const-string v8, "00001124-0000-1000-8000-00805f9b34fb"

    invoke-static {v6, v8, v0}, Lkotlin/text/StringsKt;->equals(Ljava/lang/String;Ljava/lang/String;Z)Z

    move-result v8

    if-nez v8, :cond_4

    const-string v8, "00001812-0000-1000-8000-00805f9b34fb"

    invoke-static {v6, v8, v0}, Lkotlin/text/StringsKt;->equals(Ljava/lang/String;Ljava/lang/String;Z)Z

    move-result v8

    if-eqz v8, :cond_3

    goto :goto_1

    :cond_3
    move v6, v4

    goto :goto_2

    :cond_4
    :goto_1
    move v6, v0

    .line 47
    .end local v6    # "it":Ljava/lang/String;
    .end local v7    # "$i$a$-any-RingDeviceClassifier$isCandidate$1":I
    :goto_2
    if-eqz v6, :cond_2

    move v1, v0

    goto :goto_3

    .line 48
    .end local v5    # "element$iv":Ljava/lang/Object;
    :cond_5
    move v1, v4

    .end local v1    # "$this$any$iv":Ljava/lang/Iterable;
    .end local v2    # "$i$f$any":I
    :goto_3
    if-eqz v1, :cond_6

    goto :goto_4

    :cond_6
    move v0, v4

    goto :goto_5

    :cond_7
    :goto_4
    nop

    .line 35
    :goto_5
    return v0
.end method
